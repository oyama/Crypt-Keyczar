use Test::More tests => 4;

use strict;
use warnings;
use Crypt::Keyczar::Util;

sub BEGIN { use_ok('Crypt::Keyczar::RsaPrivateKey'); }

my $JSON = q|{"primeExponentP": "AG2DodKZ7awUzK1jmokOjsaFwUYoahSf2sAOgmIRpOIukcskX1m5XHFMau7n2nAOExqBORF70-F8YPU1x3WMFKQwiAbfi0UWnzneqvjf_ulG3rLAyu5HUTCbVL69CIFLbi7tLfNBHCOHT6PPVXeWHy8cm1EJuTUhigqZmL6XrApB", "primeExponentQ": "AFLhV2paBJB5s4P6M52TfLxTf0hoGsUXtApPeJRtfTnkE3ThMWzcF0DmonoEtjys_8dCDA4hhGvD3416irbklYzLKY8Rb4Xpb6kkMTkQaG9XMJwbb97lwCToPTjza1JtAGEW_5GJdyX_VEcbTCdiV5GSjpRNStQ_Wwn5VPNBbpFn", "crtCoefficient": "AOrRfjqNYWynI-UyKUZfv7fyLCe95IxrZE3O_8Jjv4QDeZ4-E7GP0-I_igugqmmgnY9_W_FHM2BUz0Lb6YwANJDl7as7Vhp0227icspc7iJ9S79YHuw1Z0PrTb6r_y7chqfrQrAczHf6WFAP8HaIP8g4rIudRDbd2wGIyyhxCcHZ", "privateExponent": "ALZ4MfNKjRpJH_UEltHGIoypjkHIqQEIH903uHobUOXm-x7eSyCa5-L5VJbTekZXQC89b9X3XXHE68t7hcZHWgZKIEiel-i5henbZ7Rv07_NtMMASSFZYBNrXAnqIFoyhOObFz4Uh_PALfqtpP7Mn0ECfVpDw0w1a2nYjytkQ5-TEfz0WITVsECaAyWR0GgPPL4B0_Sg8xK5KoZ9EMIq_4w0wsVot9TNPaGu-fR5M8H6ST87D1ZaZdHd7Phg1zkttBPvrgF27svgzW1Vw3x6s8JdlfcrmNFM2ZlQHCtgdvg-hJY44z5E1hEcwUj927KfFWb3dUdcM4Iq6yoawCrvasE", "publicKey": {"publicExponent": "AAEAAQ", "modulus": "ANIIvh5FbJ2mQ7AFzvcaBqGPiMYVRVuxcfESC_NImfU-jopP064D2dyuxvzoKB1uNMLypqEbY3-rPkQpFWkOWn2OAQT-q-YJM8a9yS5Bbj89_0ilhHxTBpFxaWFmKmRxFhPIlSx55OprIIeo81vEbLD7NWazMVCmADZnon7GQ2zrRZVRNJz1gop2l0yCdL5ma15CiBXzVckEldzPAo6_KIedrQ3aeHazsf17Re6TH9ghkklH94jXBTlKfg6h2pxGjSjLjo5VW4qknKMB7utGcFb9C7HMCgzRPf4U_Im565SsMTPYH_nXX9coGCK9Y2TAIgozAgPK7C_m-szmUYUkBrs", "size": 2048}, "primeQ": "ANUAF-OqLWFjp8FqRuRVg4lsfFHe1_JzzJTPgupOik8Ewws4Sm2ow4arb88VLKgVFgms-NgXZV_2zC7h2vidSu79yPMMw-k92ErOzar80ArCAoCtl1GKovTuV8-9Ypb3kMAtTUENSco8oyKeoEQ_t0clefhjqB2Tg2lXUSEuoOkf", "primeP": "APxvWtDaZupEzANQ5AWOZ6CG6ccJzGYWCTgft0DdV-mzic_LXg5XNrIkRRuvaKk05ko7PfiyZfjxeL03JWoP8EywJ68a0KUc_toXq4C_PeLzic-XGexImlzjqvMM4wc9E_lU0zNHKWNKXXP2JKeBbfebP_FZ1_CumNDslOQONsLl", "size": 2048}|;

my $CT = q{AJ4lzuqCPyrOTlknD2dcCOzClftq4L3g_u0UdyhJX6to7G9rayp4m9NAMO6u6A97XaTKRxLEUifLiqY0gSXSSSpTAUdUH4KMtM1aeF1uW6JO2iH7fO-kxP1boIwZlp3f9cza5_urG-0gvjjS-uGWBcc1Xz3rh5hzpGifBgTWGdttPS46TJGDQm9IAKhF8uDTBmWfaX_bmw6jc6ViDEY1nP2jU3rjAzQYd2f9kMp26nPZqpmHbGfKuFMI_yBEm-PEFAySR2ZwB190B6WI2NTSuoFg9_1CLbF1DLFWyXUwHrYY4wECK70zqq23sNn2XcUSwgYdvbISEkXotA8MBfETmTOt8Cti};


my $key = Crypt::Keyczar::RsaPrivateKey->read($JSON);
ok($key, 'create key object');
my $engine = $key->get_engine();
ok($engine, 'create rsa engine');
my $ct_body = substr Crypt::Keyczar::Util::decode($CT), 5;

ok($engine->decrypt($ct_body) eq 'This is some test data', 'decrypt by RSA private key');
