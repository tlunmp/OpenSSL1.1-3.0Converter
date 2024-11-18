# p12UpdateConverter

Convert p12 file from OpenSSL1.1 to OpenSSL 3.

This script should resolve the issue

##[warning]Error parsing certificate. This might be caused by an unsupported algorithm. If you're using old certificate with a new OpenSSL version try to set -legacy flag in opensslPkcsArgs input.

## Guide
1. After downloading set the bash script chmod to 777
2. Sample usage
```
p12-update-converter.sh -f 'FILE_PATH_WITH_FILE_NAME' -p 'CERTIFICATE PASSWORD' -n 'OUTPUT NAME' 
```

```
p12-update-converter.sh -f 'folder/cert.p12' -p 'pass123' -n 'new_cert' 
``` 
