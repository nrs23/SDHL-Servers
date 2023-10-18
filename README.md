# Table of Contents

1.  [Usage reference](#orgc1792e2)
    1.  [Logging in](#org7256d3e)
    2.  [Log into containers](#org8d860b0)
    3.  [Access reverse proxy configurations](#orge1ead76)
    4.  [Access reverse proxy logs](#org23423ca)
    5.  [HTTPS cert renewal](#org29c94ff)
2.  [Containers running on SHL2](#org3c9e6e2)
    1.  [For claiming](#org844c96a)
        1.  [Sharon](#orgd79c888)
        2.  [Alice](#org1a3fe2c)
        3.  [Julie Weeds Collin Ashby](#org46571c7)
        4.  [Concept Analytics](#orgbf8259d)
        5.  [David Weir](#orgc46843f)
        6.  [Alex Butterworth](#org104a08a)
    2.  [Needs investigating](#org9c7b462)
        1.  [No leads](#org6b37ab5)
3.  [Command reference](#org42adad3)
    1.  [Service tags](#org212e942)
    2.  [Monitoring/alerting](#org6fe2397)
4.  [Specs](#orgec420bd)



<a id="orgc1792e2"></a>

# Usage reference


<a id="org7256d3e"></a>

## Logging in

You'll need ssh keys registered on the machines to log in. Ask the administrator (ns23@sussex.ac.uk right now)  

If you're off campus you will have to go via 'unix.uscs.susx.ac.uk', you don't need ssh keys  to log into this ( only your regular password),  but you will have to load generate and register ssh keys on this server  to access the SHL servers ( the same way as you would from your local computer).  

Server names:  

    shl1.inf.susx.ac.uk
    shl2.inf.susx.ac.uk
    shl-database.inf.susx.ac.uk


<a id="org8d860b0"></a>

## Log into containers

    sudo su # Elevate to root
    lxc list # list containers
    lxc exec queer-heritage-south -- bash # log into container named 'queer-heritage-south'


<a id="orge1ead76"></a>

## Access reverse proxy configurations

Configurations are found in:  

    /etc/nginx/nginx.conf
    /etc/nginx/proxy-lxc.conf
    /etc/nginx/conf.d/

'conf.d' is where the individual websites are configured.  


<a id="org23423ca"></a>

## Access reverse proxy logs

SHL2: '*var/log/nginx'  
SHL1: '/var/log/httpd*'  

SHL1 no longer forwards to SHL2, it is almost completely inactive  


<a id="org29c94ff"></a>

## HTTPS cert renewal

Copied verbatim from Simon's emails.  

First email:  

> Hi Nic,  
> 
> Just noting here how to renew HTTPS certs on SHL2:  
> 
> elevate to root  
>     sudo su  
> cd to home  
>     cd  
> enter the acme.sh dir  
>     cd acme.sh  
> list the certs being managed and determine the cert to be renewed  
>     ./acme.sh &#x2013;list  
> stop the webserver  
>     systemctl stop nginx  
> renew the cert  
>     ./acme.sh &#x2013;renew -d [domain name]  
> wait for success  
> start the webserver  
>     systemctl start nginx  
> 
> This process is not ideal since it requires the webserver to go down - it could potentially be automated to run at midnight or such but that could run into trouble if the webserver doesn't come back up for some reason.  
> 
> Ideally, we would use certbot which can use its nginx plugin which can update certs without taking the server down. However, that isn't working:  

    [root@shl2 sw206]# certbot
    Saving debug log to /var/log/letsencrypt/letsencrypt.log
    Plugins selected: Authenticator nginx, Installer nginx
    Starting new HTTPS connection (1): acme-v02.api.letsencrypt.org
    
    Which names would you like to activate HTTPS for?
    - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    1: shl2.inf.sussex.ac.uk
    2: balder.inf.susx.ac.uk
    3: bragi.inf.susx.ac.uk
    4: eir.inf.susx.ac.uk
    5: foresti.inf.susx.ac.uk
    6: freyja.inf.susx.ac.uk
    7: freyr.inf.susx.ac.uk
    8: frigga.inf.susx.ac.uk
    9: kvasir.inf.susx.ac.uk
    10: loki.inf.susx.ac.uk
    11: njord.inf.susx.ac.uk
    12: odin.inf.susx.ac.uk
    13: skadi.inf.susx.ac.uk
    14: vor.inf.susx.ac.uk
    15: preservingcommunityarchives.co.uk
    16: queerheritagesouth.co.uk
    17: www.queerheritagesouth.co.uk
    18: reanimatingdata.co.uk
    19: archives.reanimatingdata.co.uk
    20: fact.network
    21: ifte.network
    - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    Select the appropriate numbers separated by commas and/or spaces, or leave input
    blank to select all options shown (Enter 'c' to cancel): 20
    Requesting a certificate for fact.network
    Performing the following challenges:
    http-01 challenge for fact.network
    Waiting for verification...
    Challenge failed for domain fact.network
    http-01 challenge for fact.network
    Cleaning up challenges
    Some challenges have failed.
    
    IMPORTANT NOTES:
     - The following errors were reported by the server:
    
       Domain: fact.network
       Type:   connection
       Detail: 139.184.48.71: Fetching
       http://fact.network/.well-known/acme-challenge/K-7A-FmQaVT-N6MAwuv8Kvv3XXy-B2FedbuJZKe1PPc:
       Connection reset by peer
    
       To fix these errors, please make sure that your domain name was
       entered correctly and the DNS A/AAAA record(s) for that domain
       contain(s) the right IP address. Additionally, please check that
       your computer has a publicly routable IP address and that no
       firewalls are preventing the server from communicating with the
       client. If you're using the webroot plugin, you should also verify
       that you are serving files from the webroot path you provided.

> I don't know why this doesn't work..  "Connection reset by peer" could imply the request is being cancelled by a network filter or firewall? But the acme.sh uses the same protocol (I think) and works&#x2026; You may have to take this up with ITS (Sorry!)  
> Of course let me know of any questions or if I can assist further.  
> 
> Best,  
> 
> Simon  

Second email:  

> OK, apologies, the previous is not entirely correct.  
> 
> I believe ITS are blocking letsencrypt requests / acme protocol. The reason acme.sh work is that it's using different validation methods to certbot  

    [root@shl2 acme.sh]# ./acme.sh --list
    Main_Domain                        KeyLength  SAN_Domains  CA               Created               Renew
    archives.reanimatingdata.co.uk     "2048"     no           LetsEncrypt.org  2023-09-18T16:36:14Z  2023-11-16T16:36:14Z
    fact.network                       "2048"     no           ZeroSSL.com      2023-09-22T12:43:25Z  2023-11-20T12:43:25Z
    ifte.network                       "2048"     no           ZeroSSL.com      2023-09-19T16:05:17Z  2023-11-17T16:05:17Z
    preservingcommunityarchives.co.uk  "2048"     no           ZeroSSL.com      2023-09-18T16:38:07Z  2023-11-16T16:38:07Z
    queerheritagesouth.co.uk           "2048"     no           LetsEncrypt.org  2023-09-21T15:37:36Z  2023-11-19T15:37:36Z
    reanimatingdata.co.uk              "2048"     no           ZeroSSL.com      2023-09-18T16:37:06Z  2023-11-16T16:37:06Z
    www.queerheritagesouth.co.uk       "2048"     no           LetsEncrypt.org  2023-09-21T15:37:51Z  2023-11-19T15:37:51Z

> The ZerroSSL.com ones are using DNS validation using cloud flare - acme.sh uses the cloudflare API to insert a validation record. Or it's using ALNP which enables letsencrypt to validate over port 443 only (rather than the default port 80 which is what I suspect ITS are blocking)  
> 
> Certbot don't support either of those methods out of the box (looks like there's a script to enable DNS). But the good news is the the ZeroSSL.com ones (DNS validation) don't require the webserver to go down.  
> 
> <https://dash.cloudflare.com/>  
> 
> User: simon.wibberley@sussex.ac.uk  
> Pass: I'll send separately  
> 
> Apologies for how needlessly complex this is! Again, more than happy to provide support / advice going forward.  
> 
> Best,  
> 
> Simon  


<a id="org3c9e6e2"></a>

# Containers running on SHL2

[SHL2 containers list](tables.md)  


<a id="org844c96a"></a>

## For claiming


<a id="orgd79c888"></a>

### Sharon

1.  Known wordpress sites

    <https://fact.network/>  
    <https://ifte.network/>  
    <https://preservingcommunityarchives.co.uk/>  
    <https://reanimatingdata.co.uk/>  

2.  archives-reanimatingdata

3.  fact

4.  ifte

5.  queer-heritage-south

6.  hahp-omeka-s

    School of History, Art History and Philosophy  
    <https://eir.inf.susx.ac.uk/>  
    'Art and the city'  

7.  factchecking

    balder.inf.susx.ac.uk  

8.  preser

    preservingcommunityarchives.co.uk  

9.  reanim

    reanimatingdata.co.uk  


<a id="org1a3fe2c"></a>

### Alice

1.  knepp


<a id="org46571c7"></a>

### Julie Weeds Collin Ashby

1.  tellmi

    Digital peer support app?  


<a id="orgbf8259d"></a>

### Concept Analytics

1.  AA2133

    Albertus Andito  


<a id="orgc46843f"></a>

### David Weir

1.  love-island

    Jack Pay  

2.  jc

    Uses crisisMMD NLP, very david weir  
    Also OpenCalais semantic news analysis so very similar  
    From initials, more likely to be justin crow (phd student) than Prof John Caroll  
    Justin.Crow@sussex.ac.uk  

3.  intek

4.  brat-test

5.  bert-topic

    Language model  
    <https://en.wikipedia.org/wiki/BERT_(language_model)>  

6.  crawler

    Likely to be CASM's crawler  


<a id="org104a08a"></a>

### Alex Butterworth

1.  toolsofknowledge

    Running apache and postgres but can't see anything else  
    
    Seems to run something called popularity contest daily through cron -> this seems to be an OS monitoring thing  

2.  duncanhay

    Possibly related to <https://toolsofknowledge.org/>  
    That website has IP 198.181.116.9 San Francisco?  
    So maybe not hosted on servers  
    
    Running nginx, postgres and some user python code called SEMSIM which seems to have data associated with tools of knowledge  

3.  lysander

    uses neo4j database  
    at loki.inf.susx.ac.uk:  
    'the flights of lysander', shl icon,someone named 'dave'  
    earching sussex website, the project is:  
    The Lysander Flights: a story told through digital cartography  
    which belongs to Christopher Warne,David banks, and alex butterworth  


<a id="org9c7b462"></a>

## Needs investigating


<a id="org6b37ab5"></a>

### No leads

1.  etherpad

    No user set up in home dir  
    Collaborative text editor  
    freyja.inf.susx.ac.uk  

2.  matomo

    Web analytics platform?  
    freyr.inf.susx.ac.uk  


<a id="org42adad3"></a>

# Command reference


<a id="org212e942"></a>

## Service tags

Service tag is essentially serial:  

    dmidecode   | grep -C 4  Serial


<a id="org6fe2397"></a>

## Monitoring/alerting

Monit: '/etc/monit'  


<a id="orgec420bd"></a>

# Specs

12(14?) cores. 2.1GHz  
8 x 32 GB RAM = 256 GB RAM  

