################################################################################
# CA and certificate settings
################################################################################

# list of CA slugs
ROOT_CA					:= root-ca
SIGNING_CA				:= intermediate-ca
ISSUING_CA				:= component-ca identity-ca
ALL_CA					:= $(ROOT_CA) $(SIGNING_CA) $(ISSUING_CA)

# distiguished name defaults
export DN_C				?= DE
export DN_ST			?= Bayern
export DN_L				?= Strunzenoed
export DN_O				?= Example
export DN_OU			?= $(DN_O) PKI

# default reason for certificate revocation
# ref: https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.13
# unspecified: 			revoke a certificate without providing a specific reason code
# keyCompromise: 		the private key associated with the certificate has been compromised
# cACompromise: 		the CA's private key has been compromised
# affiliationChanged: 	user has terminated his or her relationship with the organization
# superseded:			replacement certificate has been issued to a user
# cessationOfOperation:	CA is decommissioned, no longer to be used
# certificateHold:		temporary revocation that indicates that a CA will not vouch for a certificate
# removeFromCRL:		certificate is revoked with CertificateHold reason, it is possible to "unrevoke"
# privilegeWithdrawn:	privileges granted to the subject of the certificate have been withdrawn
# aACompromise:			attribute authority has been compromised
REASON					?= superseded

################################################################################
# CA URL settings
################################################################################

# base URL of pki, where WEBDIR is found, also used as AIA and CDP base
export BASE_URL			:= http://pki.example.com

# OCSP base URL for Online Certificate Status Protocol
export OCSP_URL			:= http://ocsp.example.com

################################################################################
# Key and hash algorithm settings
################################################################################

# default RSA bit length in cnf files
export DEFAULT_BITS		?= 4096

# default settings for hash in cnf files
export DEFAULT_MD		?= sha3-256

# CA Keys:
# param for openssl genpkey -algorithm $(CAK_ALG)
CAK_ALG					?= ED25519
#CAK_ALG					?= RSA -pkeyopt rsa_keygen_bits:8192

# Certificate Private Keys
# param for openssl genpkey -algorithm $(CPK_ALG)
# NOTE: ED25519 p12 client certificates still fail to import in Browsers
#CPK_ALG					?= ED25519
CPK_ALG					?= RSA -pkeyopt rsa_keygen_bits:$(DEFAULT_BITS)
