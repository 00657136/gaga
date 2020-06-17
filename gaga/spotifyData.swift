//
//  spotifyData.swift
//  gaga
//
//  Created by User17 on 2020/6/16.
//  Copyright © 2020 NTOU. All rights reserved.
//

import Foundation

struct spotifyProfileData: Identifiable {
    var id: String
    var name: String
    var imgurl: String
    var popularity: Int
}


//spotify token
/*GET https://accounts.spotify.com/authorize?client_id=4499fcf4fa404fa3a5a9a43cc9cc22fa&response_type=code&redirect_uri=https://github.com/00657136/gaga/tree/master/redirect-callback  */

/*
 
 4499fcf4fa404fa3a5a9a43cc9cc22fa:dc3ac28ba4c041219ac032991c7c3f18

 playlist-read-private
 AQCLozwYq17us0Ghhp_tQc8MuQqHkhobtkCOmMEHYVzv-XBgwUyTntxug_5ci6UjoSG7DokQbQz24MEszFvi0tdntDvV2JB0SumhD8vAiGhikObFkh_voIpAzE6nOOjrFG4-mJlBt6b81M_EETAKQZ1anvyV5y-gNvWPNFTAnrqnboJ79lJd1E2mHJzoWs3GMYSLQQ3HRv4BEpRYRR-Fbk8d2AziF9E
 
 GET https://accounts.spotify.com/authorize?client_id=4499fcf4fa404fa3a5a9a43cc9cc22fa&response_type=code&redirect_uri=https%3A%2F%2Fgithub.com%2F00657136%2Fgaga%2Ftree%2Fmaster&scope=playlist-read-private
 
 curl -H "Authorization: Basic NDQ5OWZjZjRmYTQwNGZhM2E1YTlhNDNjYzljYzIyZmE6ZGMzYWMyOGJhNGMwNDEyMTlhYzAzMjk5MWM3YzNmMTg=" -d grant_type=authorization_code -d code=AQDdo1q-zmT81dx7fE76kqQEzEm28TD53rQ5iuQQ8JtcTDCjeth6JdxFA1x6H62a33_gdNpXga4UrjTWDVqJ7NCax8jPweAC2dPE7h0c25SIShaMMNBPuxJw70VM2MExhcmf1pSlCBwdthsk06bvqBn9sy_v3XcAqc2SGMAbAuOJYf5aqU98P7sKqJ4Awa8rDHAPoS6C2s8qD-maZxlvMGtH8cIAsAE&state=34fFs29kd09 -d redirect_uri=https%3A%2F%2Fgithub.com%2F00657136%2Fgaga%2Ftree%2Fmaster https://accounts.spotify.com/api/token
 
 curl -H "Authorization: Basic NDQ5OWZjZjRmYTQwNGZhM2E1YTlhNDNjYzljYzIyZmE6ZGMzYWMyOGJhNGMwNDEyMTlhYzAzMjk5MWM3YzNmMTg=" -d grant_type=authorization_code -d code=AQDdo1q-zmT81dx7fE76kqQEzEm28TD53rQ5iuQQ8JtcTDCjeth6JdxFA1x6H62a33_gdNpXga4UrjTWDVqJ7NCax8jPweAC2dPE7h0c25SIShaMMNBPuxJw70VM2MExhcmf1pSlCBwdthsk06bvqBn9sy_v3XcAqc2SGMAbAuOJYf5aqU98P7sKqJ4Awa8rDHAPoS6C2s8qD-maZxlvMGtH8cIAsAE&state=34fFs29kd09 -d redirect_uri=https%3A%2F%2Fgithub.com%2F00657136%2Fgaga%2Ftree%2Fmaster https://accounts.spotify.com/api/token
 
 {"access_token":"BQBmmszQsYIo2B_BvobbgNnwr1t1ghq3Esxa22-OvyAkadrSQQk2d8FjYW6rWFupoGubu6whQpWmbN0EGu0zo3oSPd7jvqRFoW3kTQlKuWlFTF0ykRBvzs_beuirkkd6oMbLrJX2rGJZwchTsk12rRGByQfy","token_type":"Bearer","expires_in":3600,"refresh_token":"AQCnSfyIOtgnD2xY-bINyEqwPnYeyYgiDVO665OfOz5FKeedZqQg5KZlNKaQUSu1nPZ2POD9PNYrgRfpz2oMSciz38Huj99_sDJc2CNt-eoes4Sl9XuSVhiYGEEnNnd8Rzc","scope":"playlist-read-private"}%
 
 
 curl -H "Authorization: Basic NDQ5OWZjZjRmYTQwNGZhM2E1YTlhNDNjYzljYzIyZmE6ZGMzYWMyOGJhNGMwNDEyMTlhYzAzMjk5MWM3YzNmMTg=" -d grant_type=refresh_token -d refresh_token=AQCnSfyIOtgnD2xY-bINyEqwPnYeyYgiDVO665OfOz5FKeedZqQg5KZlNKaQUSu1nPZ2POD9PNYrgRfpz2oMSciz38Huj99_sDJc2CNt-eoes4Sl9XuSVhiYGEEnNnd8Rzc https://accounts.spotify.com/api/token

{"access_token":"BQAkaNSjTEjLUFPPUxFKFsUymDEnltyTPZOOgJ7FJwWqMsK76rRXFzHETFQoji8Jy71DNqSDqS4voBazFbkmN-uEho6XFsOYp7ZMAQ2lCOAFP7-YiT6InlW9a3KQC5vicBM1N7cY-DkYaLTNG3RDooNQTL3y","token_type":"Bearer","expires_in":3600,"scope":"playlist-read-private"}
 
 */
