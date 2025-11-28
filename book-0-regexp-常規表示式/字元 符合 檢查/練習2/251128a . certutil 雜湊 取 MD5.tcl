set get_info {
= <time:10:34:36>            certutil -hashfile ./902D77217C60/operational.pem MD5                                                                       =
= MD5 的 ./902D77217C60/operational.pem 雜湊:                                                                                                            =
= 8c3b1e89abee815b785f4cf52244b08f                                                                                                                       =
= CertUtil: -hashfile 命令成功完成。                                                                                                                     =
= D:\Dropbox\12-Office-SyncMTS-Switch\01_ECS4150_01_SHA\04_ECS4150-28_54PT_V4.1.11r.254.1H.01E_SHA\extapp\FTP_TFTP_AUTO\apcode_certs>                    =
=                                                                                                                                                        =
}

set pattern {[0-9A-Za-z]{32}}
regexp -all -inline $pattern $get_info
輸出: 8c3b1e89abee815b785f4cf52244b08f
