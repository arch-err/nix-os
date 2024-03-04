{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    hacking-tools.enable =
      lib.mkEnableOption "enable hacking tools";
  };


  config = lib.mkIf config.hacking-tools.enable {

    nixpkgs.config.permittedInsecurePackages = [
      "python-2.7.18.7"
      "tightvnc-1.3.10"
    ];

    environment.systemPackages = with pkgs; [

      # Bluetooth tools
      bluez
      bluewalker
      python3Packages.bleak
      redfang
      ubertooth

      # Cloud
      cloud-nuke
      cloudfox
      ec2stepshell
      gato
      gcp-scanner
      ggshield
      goblob
      imdshift
      prowler
      yatas

      # # Container analysing tools
      # cdk-go
      # clair
      # cliam
      # cloudlist
      # dive
      # dockle
      # fwanalyzer
      # grype
      # trivy

      # # Code analysing tools, incl. search for secrets and alike in code
      # bomber-go
      # cargo-audit
      # credential-detector
      # deepsecrets
      # detect-secrets
      # freeze
      # git-secret
      # gitjacker
      # gitleaks
      # gitls
      # gokart
      # legitify
      # osv-detector
      # packj
      # pip-audit
      # python310Packages.safety
      # secretscanner
      # tell-me-your-secrets
      # trufflehog
      # whispers

      # # Tools for DNS queries and enumeration
      # aiodnsbrute
      # amass
      # bind
      # dnsenum
      # dnsmon-go
      # dnsmonster
      # dnsrecon
      # dnstake
      # dnstracer
      # dnstwist
      # dnspeep
      # dnsx
      # fierce
      # findomain
      # knockpy
      # subfinder
      # subzerod
  
      # # Exploits
      # exploitdb
      # go-exploitdb
      # keedump
      # padre
      # # log4j
      # lmp
      # log4jcheck
      # log4j-detect
      # log4j-scan
      # log4j-sniffer
      # log4j-vuln-scanner
      # logmap

      # # Forensic tools
      # afflib
      # amoco
      # acquire
      # dcfldd
      # ddrescue
      # dislocker
      # dismember
      # exiv2
      # ext4magic
      # extundelete
      # foremost
      # gef
      # gzrt
      # hivex
      # hstsparser
      # noseyparker
      # ntfs3g
      # ntfsprogs
      # nwipe
      # recoverjpeg
      # safecopy
      # sleuthkit
      # srm
      # stegseek
      # testdisk
      # volatility3
      # wipe
      # xorex
      # 
      # # Fuzzing tools
      # afl
      # aflplusplus
      # feroxbuster
      # ffuf
      # gobuster
      # honggfuzz
      # radamsa
      # regexploit
      # scout
      # ssdeep
      # wfuzz
      # zzuf

      # # Generic tools (terminals, packers, clients, etc.)
      # chrony
      # clamav
      # curl
      # cyberchef
      # dorkscout
      # easyeasm
      # exiflooter
      # flashrom
      # girsh
      # httpie
      # hurl
      # inetutils
      # inxi
      # ioccheck
      # iproute
      # iproute2
      # macchanger
      # pwgen
      # ronin
      # spyre
      # utillinux
      # xh

      # # Terminal helpers
      # eternal-terminal
      # mosh
      # shellz

      # # Common client for various protocols
      # cifs-utils
      # freerdp
      # net-snmp
      # nfs-utils
      # ntp
      # openssh
      # openvpn
      # samba
      # step-cli
      # tightvnc
      # wireguard-go
      # wireguard-tools
      # xrdp

      # # Network design helpers
      # ipcalc
      # netmask

      # # Terminal multiplexer
      # tmux
      # zellij

      # # Archive tools
      # cabextract
      # p7zip
      # unrar
      # unzip

      # # Tools and libraries to access hardware
      # cantoolz
      # chipsec
      # cmospwd
      # esptool
      # extrude
      # gallia
      # hachoir
      # nrfutil
      # tytools
      # python3Packages.angr
      # python3Packages.angrop
      # python3Packages.can
      # python3Packages.pyi2cflash
      # python3Packages.pyspiflash
      # routersploit

      # # Host security tools
      # checksec
      # chkrootkit
      # linux-exploit-suggester
      # lynis
      # safety-cli
      # tracee
      # vulnix

      # # Tools for informtion gathering
      # cloudbrute
      # enumerepo
      # holehe
      # maigret
      # metabigor
      # p0f
      # sn0int
      # socialscan
      # theharvester
      # urlhunter

      # # Kubernetes infrastructure
      # cfripper
      # checkov
      # cirrusgo
      # kdigger
      # kube-score
      # kubeaudit
      # kubestroyer
      # kubescape
      # popeye

      # # LDAP/AD tools
      # adenum
      # msldapdump
      # ldapmonitor
      # ldapdomaindump
      # ldapnomnom
      # ldeep
      # silenthound

      # # Load testing tools
      # ali
      # drill
      # cassowary
      # ddosify
      # oha
      # siege
      # tsung
      # vegeta
      #  
      # # Useful tools for malware analysis
      # bingrep
      # cutter
      # flare-floss
      # gdb
      # ghidra-bin
      # ioc-scan
      # pev
      # pwndbg
      # python3Packages.binwalk
      # python3Packages.malduck
      # python3Packages.karton-core
      # python3Packages.unicorn
      # python3Packages.r2pipe
      # radare2
      # radare2-cutter
      # rizin
      # stacs
      # unicorn
      # unicorn-emu
      # xortool
      # yara
      # zkar
      # zydis

      # # Various tools
      # ares-rs
      # badchars
      # changetower
      # creds
      # doona
      # galleta
      # honeytrap
      # jwt-cli
      # kepler
      # nmap-formatter
      # pwntools
      # python3Packages.pytenable
      # snscrape

      # # Tools for working with Android/iOS devices
      # abootimg
      # androguard
      # apkeep
      # apkleaks
      # apktool
      # dex2jar
      # genymotion
      # ghost
      # payload-dumper-go
      # scrcpy
      # simg2img
      # trueseeing

      # # Common network tools
      # arping
      # atftp
      # bandwhich
      # crackmapexec
      # evillimiter
      # iperf2
      # lftp
      # mitm6
      # mtr
      # ncftp
      # netcat-gnu
      # netdiscover
      # nload
      # nuttcp
      # putty
      # pwnat
      # responder
      # rustcat
      # sshping
      # sslh
      # wbox
      # whois
      # yersinia

      # # Tools to generate packets
      # boofuzz
      # gping
      # fping
      # hping
      # ostinato
      # pktgen
      # python3Packages.scapy

      # # Password and hashing tools
      # authoscope
      # bruteforce-luks
      # brutespray
      # crunch
      # h8mail
      # hashcat
      # hashcat-utils
      # hashdeep
      # john
      # legba
      # medusa
      # nasty
      # ncrack
      # nth
      # phrasendrescher
      # python3Packages.patator
      # thc-hydra
      # truecrack
 
      # # Port scanners
      # arp-scan
      # das
      # ipscan
      # masscan
      # naabu
      # nmap
      # udpx
      # sx-go
      # rustscan
      # zmap

      # # Proxy tools for MitM scenarios
      # bettercap
      # burpsuite
      # ettercap
      # mitmproxy
      # mubeng
      # proxify
      # proxychains
      # redsocks
      # rshijack
      # zap

      # # Tools for testing various services (SSH, SNMP, etc.)
      # acltoolkit
      # checkip
      # ghunt
      # ike-scan
      # keepwn
      # metasploit
      # nbutools
      # nuclei
      # openrisk
      # osv-scanner
      # uncover
      # traitor
      # # E-Mail
      # mx-takeover
      # ruler
      # swaks
      # trustymail
      # # Databases
      # ghauri
      # mongoaudit
      # pysqlrecon
      # sqlmap
      # # SNMP
      # braa
      # onesixtyone
      # snmpcheck
      # # SSH
      # baboossh
      # sshchecker
      # ssh-audit
      # ssh-mitm
      # # IDS/IPS/WAF
      # teler
      # waf-tester
      # wafw00f
      # # CI
      # oshka
      # # Terraform
      # terrascan
      # tfsec
      # # Supply chain
      # chain-bench
      # witness
      # # WebDAV
      # davtest

      # # Smartcard tools
      # cardpeek
      # libfreefare
      # mfcuk
      # mfoc
      # python3Packages.emv

      # # Terminal tools
      # cutecom
      # minicom
      # picocom
      # socat
      # x3270
      # sslscan
      # ssldump
      # sslsplit
      # testssl
      # tlsx
      #  
      # # Tools to capture network traffic
      # anevicon
      # dhcpdump
      # dnstop
      # driftnet
      # dsniff
      # goreplay
      # joincap
      # junkie
      # netsniff-ng
      # ngrep
      # secrets-extractor
      # sniffglue
      # tcpdump
      # tcpflow
      # tcpreplay
      # termshark
      # wireshark
      # wireshark-cli
      # zeek

      # # Tunneling tools
      # bore-cli
      # corkscrew
      # hans
      # chisel
      # httptunnel
      # iodine
      # sish
      # stunnel
      # udptunnel
      # wstunnel

      # # VoIP/SIP tools
      # sipp
      # sipsak
      # sipvicious
      # sngrep

      # # Tools for working with web servers, web applications, APIs, etc.
      # apachetomcatscanner
      # arjun
      # brakeman
      # cansina
      # cariddi
      # chopchop
      # clairvoyance
      # commix
      # crackql
      # crlfsuite
      # dalfox
      # dismap
      # dirstalk
      # dontgo403
      # galer
      # gau
      # gospider
      # gotestwaf
      # gowitness
      # graphqlmap
      # graphw00f
      # hakrawler
      # hey
      # httpx
      # nodePackages.hyperpotamus
      # jaeles
      # jsubfinder
      # jwt-hack
      # katana
      # kiterunner
      # mantra
      # mitmproxy2swagger
      # monsoon
      # nikto
      # ntlmrecon
      # photon
      # plecost
      # scraper
      # slowlorust
      # snallygaster
      # subjs
      # swaggerhole
      # uddup
      # wad
      # webanalyze
      # websecprobe
      # whatweb
      # wprecon
      # wpscan
      # wuzz
      # xcrawl3r
      # xsubfind3r

      # # Microsoft infrastructure and Windows-related tools, incl. SMB
      # bloodhound-py
      # chainsaw
      # certipy
      # certsync
      # coercer
      # enum4linux
      # enum4linux-ng
      # erosmb
      # evil-winrm
      # go365
      # gomapenum
      # kerbrute
      # knowsmore
      # lil-pwny
      # nbtscan
      # nbtscanner
      # offensive-azure
      # python3Packages.lsassy
      # python3Packages.pypykatz
      # samba
      # smbmap
      # smbscan

      # # Wireless tools
      # aircrack-ng
      # airgeddon
      # bully
      # cowpatty
      # dbmonster
      # horst
      # killerbee
      # kismet
      # pixiewps
      # reaverwps
      # wavemon
      # wifite2
      # zigpy-cli

    ];
  };
}
