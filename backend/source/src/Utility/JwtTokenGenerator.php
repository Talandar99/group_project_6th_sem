<?php
namespace App\Utility;

use Firebase\JWT\JWT;

class JwtTokenGenerator {
    public static function generateToken($user) {
        $key = '86d2396fe2837b88a9b78ff66b291dfdbb919ad91b110deabe0b9571e2a1cfdf0b38efd0674bdc549fca114b41a82d016f509a073c9587c0ca43ff309f45ae2358d8561e4c6894906774ef2110fb5418738a325dc591bc58b2aee984f90b390ec4a3ccf7ff571e0420d6d0aa41d91ed56d93de279a6832273579d1905c21d428f0e6f77e76a8b8607944e8167f77679c7ce89237a0cc97f5a3cb23705aee1e4e4494ec7ec37154103b14113b58dbf5588c92f6c4956a521cf2a369648dbf6818edb90055f3d6602bc233bf287a170dadb191b0f855a222993f408fbe3774b2a04cbdaf47b94d1082fc0004684c2e5f87cdd76553448f7c661ef4cf78f2496f97e991739d6bd7f829d79223672a3c4f98ad780a771ff130dfb83d3d34d380052d1e5589890fbeb5ee510db33198be2103698a8d63bfd800fa687489ed3a6901e14674ec028593b32ba0198e9851f6e3d267d9dcdbb6bdf6e10d815dbad4c53fce565bd21f59365d1bf85dd64440e6196bb853deae62f652e8e26a0998d3df9bc7'; // Zamień na swój rzeczywisty klucz
        $payload = [
            'user_id' => $user->id,
            'id' => $user->id,
            'sub' => $user->id,
            'exp' => time() + 3600,  // Ważność tokenu: 1 godzina
        ];

        return JWT::encode($payload, $key, 'HS256'); // HS256 to algorytm podpisywania
    }
}
