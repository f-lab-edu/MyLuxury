//
//  MemberRepositoryImpl.swift
//  MyLuxury
//
//  Created by KoSungmin on 10/16/24.
//

import Foundation
import Combine
import Domain
import AuthenticationServices
import FirebaseAuth
import FirebaseFirestore

public class MemberRepositoryImpl: NSObject, MemberRepository {
    private let signInSuccessPublisher: PassthroughSubject<String, Never> = .init()
    
    override public init() {
        print("MemberRepositoryImpl init")
    }
    
    deinit {
        print("MemberRepositoryImpl deinit")
    }

    public func appleLogin() -> AnyPublisher<String, Never> {
        startSignInWithApple()
        
        return signInSuccessPublisher.eraseToAnyPublisher()
    }
    
    public func logout() -> Bool {
        do {
            try Auth.auth().signOut()
            print("애플 로그아웃 성공")
            return true
        } catch {
            print("애플 로그아웃 실패")
            return false
        }
    }
    
    func startSignInWithApple() {
        /// 애플 로그인 요청 생성
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        /// 요청하는 정보는 이름과 이메일
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }
}

extension MemberRepositoryImpl: ASAuthorizationControllerDelegate {
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        /// appleIDCreential은 애플 Sign-In 과정에서 Apple이 제공하는 사용자 데이터를 담고 있음.
        /// user: 애플에서 제공하는 사용자 고유 ID. 앱 내에서 고유하며, 회원 탈퇴 후 재생성히 다를 수 있음.
        /// fullName: 사용자 전체 이름으로 familyName과 givenName으로 이루어져 있음.
        /// email: 사용자의 이메일. 처음 애플 로그인을 할 때만 제공됨.
        /// identityToken: Firebase인증에서 사용되는 JWT 토큰으로 Data 타입.
        /// authorizationCode: Apple 인증 서버에서 반환된 인증 코드. 서버 측 검증 사용 용도.
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let identityToken = appleIDCredential.identityToken,
                  let tokenString = String(data: identityToken, encoding: .utf8) else {
                print("식별 토큰을 불러올 수 없음")
                /// 애플 로그인이 실패했음을 최종적으로 뷰컨트롤러에 알림.
                signInSuccessPublisher.send(completion: .finished)
                return
            }
            /// firebase 인증
            let credential = OAuthProvider.appleCredential(withIDToken: tokenString, rawNonce: nil, fullName: appleIDCredential.fullName)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("애플 로그인 에러: \(error.localizedDescription)")
                    /// 애플 로그인이 실패했음을 최종적으로 뷰컨트롤러에 알림.
                    self.signInSuccessPublisher.send(completion: .finished)
                    return
                }
                /// 로그인 성공 로직
                
                /// authResult.user는 Firebase에 인증된 사용자의 정보를 담고 있음.
                /// uid: Firebase에서 생성한 고유 사용자 ID. 컬렉션의 각 문서당 식별자가 되는 값.
                /// email: 사용자 이메일. 로그인 시 제공하지 않았다면 nil
                /// displayName: Apple 로그인에서 제공하지 않았다면 nil
                guard let user = authResult?.user else { return }
                let isNewUser = authResult?.additionalUserInfo?.isNewUser ?? false
                if isNewUser {
                    /// 신규 사용자이므로 회원가입 로직
                    self.handleSignUp(userId: user.uid, appleIDCredential: appleIDCredential)
                } else {
                    /// 기존 사용자이므로 FireStore에서 데이터 조회
                    self.handleSignIn(userId: user.uid)
                }
            }
        }
    }
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        print("애플 로그인 에러: \(error.localizedDescription)")
    }
    
    /// 로그인 로직
    private func handleSignIn(userId: String) {
        let db = Firestore.firestore()
        db.collection("User").document(userId).getDocument { document, error in
            if let error = error {
                print("사용자 로그인 처리 실패: \(error.localizedDescription)")
                return
            }
            if let document = document, document.exists {
                KeyChainManager.addItem(key: "userId", value: userId)
                self.signInSuccessPublisher.send(userId)
            }
        }
    }
    
    /// 회원가입 로직
    private func handleSignUp(userId: String, appleIDCredential: ASAuthorizationAppleIDCredential) {
        let db = Firestore.firestore()
        let fullName = "\(appleIDCredential.fullName?.familyName ?? "")\(appleIDCredential.fullName?.givenName ?? "")"
        let email = appleIDCredential.email ?? "Null"
        
        /// 처음 제공되는 값으로 사용자 회원가입. Firestore에 저장
        /// User 컬렉션에 새로운 문서 생성
        db.collection("User").document(userId).setData([
            "userId": userId,
            "userName": fullName.isEmpty ? "Null" : fullName,
            "userEmail": email,
            "userGrade": UserGrade.normal.rawValue,
            "createdAt": FieldValue.serverTimestamp()   /// Timestamp 타입
        ]) { error in
            if let error = error {
                print("사용자 회원가입 실패: \(error.localizedDescription)")
            } else {
                print("사용자 회원가입 성공")
                /// 회원가입 완료 후 로그인 처리
                self.handleSignIn(userId: userId)
            }
        }
    }
}

