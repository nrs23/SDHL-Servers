# Table of Contents

1.  [Usage reference](#orge8d7ae6)
    1.  [Logging in](#org4fc63b1)
    2.  [Log into containers](#orga37329b)
    3.  [Access reverse proxy configurations](#org3cbba0f)
    4.  [Access reverse proxy logs](#org41dfc6f)
2.  [Containers running on SHL2](#org7d1c448)
    1.  [For claiming](#org376a67b)
        1.  [Sharon](#org1315955)
        2.  [Alice](#org1d259fc)
        3.  [Julie Weeds Collin Ashby](#orgf65da33)
        4.  [Concept Analytics](#org6f7c757)
        5.  [David Weir](#org002c8c0)
        6.  [Alex Butterworth](#org83a42e4)
    2.  [Needs investigating](#org98f369b)
        1.  [No leads](#org904787f)
3.  [Command reference](#org449ad65)
    1.  [Service tags](#org5342b3c)
    2.  [Monitoring/alerting](#orgbf8a350)
4.  [Specs](#org8732d91)



<a id="orge8d7ae6"></a>

# Usage reference


<a id="org4fc63b1"></a>

## Logging in

You'll need ssh keys registered on the machines to log in. Ask the administrator (ns23@sussex.ac.uk right now)  

If you're off campus you will have to go via 'unix.uscs.susx.ac.uk', you don't need ssh keys  to log into this ( only your regular password),  but you will have to load generate and register ssh keys on this server  to access the SHL servers ( the same way as you would from your local computer).  

Server names:  

    shl1.inf.susx.ac.uk
    shl2.inf.susx.ac.uk
    shl-database.inf.susx.ac.uk


<a id="orga37329b"></a>

## Log into containers

    sudo su # Elevate to root
    lxc list # list containers
    lxc exec queer-heritage-south -- bash # log into container named 'queer-heritage-south'


<a id="org3cbba0f"></a>

## Access reverse proxy configurations

Configurations are found in:  

    /etc/nginx/nginx.conf
    /etc/nginx/proxy-lxc.conf
    /etc/nginx/conf.d/

'conf.d' is where the individual websites are configured.  


<a id="org41dfc6f"></a>

## Access reverse proxy logs

SHL2: '*var/log/nginx'  
SHL1: '/var/log/httpd*'  

SHL1 no longer forwards to SHL2, it is almost completely inactive  


<a id="org7d1c448"></a>

# Containers running on SHL2

[SHL2 containers list](tables.md)  


<a id="org376a67b"></a>

## For claiming


<a id="org1315955"></a>

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


<a id="org1d259fc"></a>

### Alice

1.  knepp


<a id="orgf65da33"></a>

### Julie Weeds Collin Ashby

1.  tellmi

    Digital peer support app?  


<a id="org6f7c757"></a>

### Concept Analytics

1.  AA2133

    Albertus Andito  


<a id="org002c8c0"></a>

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


<a id="org83a42e4"></a>

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


<a id="org98f369b"></a>

## Needs investigating


<a id="org904787f"></a>

### No leads

1.  etherpad

    No user set up in home dir  
    Collaborative text editor  
    freyja.inf.susx.ac.uk  

2.  matomo

    Web analytics platform?  
    freyr.inf.susx.ac.uk  


<a id="org449ad65"></a>

# Command reference


<a id="org5342b3c"></a>

## Service tags

Service tag is essentially serial:  

    dmidecode   | grep -C 4  Serial


<a id="orgbf8a350"></a>

## Monitoring/alerting

Monit: '/etc/monit'  


<a id="org8732d91"></a>

# Specs

12(14?) cores. 2.1GHz  
8 x 32 GB RAM = 256 GB RAM  


