# Application verification

## Verifing MSIX file

## Verifing DMG file

## Verify Android file

Application should be installed via Google Play Store.

## Verifying a downloaded files with GPG

Import all public keys under `doc/signing_keys`(https://github.com/LeastAuthority/destiny/tree/main/doc/signing_keys)
```
curl https://raw.githubusercontent.com/LeastAuthority/destiny/main/doc/signing_keys/donatas_la.pub| gpg --import
curl https://raw.githubusercontent.com/LeastAuthority/destiny/main/doc/signing_keys/ewanas_la.pub| gpg --import
```

To verify a download, download the `.sig` file corresponding to your download
and run `gpg --verify <path of the sig file>`

Check if signature is good, should find similar line `gpg: Good signature from "El-Hassan Wanas <wanas@leastauthority.com>" [unknown]`
Note: There can be warning below, because you have not marked public key as trusted yet.

In case, signature is invalid, you should see `gpg: BAD signature from`. Such file must not be used.

