#!/bin/bash

p12_file_path_name=""
cert_password=""
output_name=""
help_opened=""

while getopts f:p:n:h opt; do
        case $opt in
                f) p12_file_path_name=$OPTARG ;;
                p) cert_password=$OPTARG ;;
		n) output_name=$OPTARG ;;
		h) help_opened="true" ;;
                *) echo 'Error no options' >&2
                        exit 1
        esac
done

checkOptions()
{
  if [ ! -z "$help_opened" ]; then
	echo -e "\n============"
	echo -e "Help Options"
	echo -e "============\n"
	echo -e "\t-f Include Path and File Name\n" 
	echo -e "\t-p Certification Password, Include Single Quotes\n"
	echo -e "\t-n Output Name\n"
  	exit 1
  fi

  if [ -z "$p12_file_path_name" ]; then
  	echo 'Missing -f File Path Name Option' >&2
  	exit 1
  fi

  if [ -z "$cert_password" ]; then
  	echo 'Missing -p Certification Password Option' >&2
  	exit 1
  fi
}

creatingATemporaryLegacyCertificateCopy()
{
  cp $p12_file_path_name temp_certificate.p12
}

conversionPEM()
{
  openssl pkcs12 -legacy -in temp_certificate.p12 -out temp_certificate.pem -nodes -passin pass:$cert_password
}

extractingPrivateKey()
{
  openssl pkcs12 -legacy -in temp_certificate.p12 -nocerts -out temp_certificate.key -passin pass:$cert_password -passout pass:$cert_password
}

creatingNewCertificate()
{
  if [ -z "$output_name" ]; then
	openssl pkcs12 -export -out converted_cert.p12 -inkey temp_certificate.key -in temp_certificate.pem -passin pass:$cert_password -passout pass:$cert_password
  else
	openssl pkcs12 -export -out $output_name.p12 -inkey temp_certificate.key -in temp_certificate.pem -passin pass:$cert_password -passout pass:$cert_password
  fi
}

deletingTemporaryFiles()
{
  rm -rf temp_certificate.p12 temp_certificate.pem temp_certificate.key
}

checkOptions
creatingATemporaryLegacyCertificateCopy
conversionPEM
extractingPrivateKey
creatingNewCertificate
deletingTemporaryFiles
