import Foundation

//import SwiftJWT
//
//let header = Header(typ: "JWT", kid: "223HRDUCVQ")
//let claims = ClaimsStandardJWT(
//                iss: "U44NN2KVQD",
//                exp: Date(timeIntervalSinceNow: 86400),
//                iat: Date()
//             )
//var jwt = JWT(header: header, claims: claims)
//
//let p8 = """
//-----BEGIN PRIVATE KEY-----
//<key>
//-----END PRIVATE KEY-----
//""".data(using: .utf8)!
//
//let signedToken = try jwt.sign(using: .es256(privateKey: p8))
//print(signedToken)
