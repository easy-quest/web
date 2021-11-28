Retrieving Webpages Using wget, curl and lynx
===

   20 October 2020 by Roel Van de Paar

   Whether you are an IT professional who needs to download 2000 online bug
   reports into a flat text file and parse them to see which ones need
   attention, or a mum who wants to download 20 recipes from an public domain
   website, you can benefit from knowing the tools which help you download
   webpages into a text based file. If you are interested in learning more
   about how to parse the pages you download, you can have a look at our Big
   Data Manipulation for Fun and Profit Part 1 article.

   In this tutorial you will learn:

     * How to retrieve/download webpages using wget, curl and lynx
     * What the main differences between the wget, curl and lynx tools are
     * Examples showing how to use wget, curl and lynx
   Retrieving Webpages Using wget, curl and lynx
   Retrieving Webpages Using wget, curl and lynx

Software requirements and conventions used

            Software Requirements and Linux Command Line Conventions
   Category    Requirements, Conventions or Software Version Used             
   System      Linux Distribution-independent                                 
   Software    Bash command line, Linux based system                          
               Any utility which is not included in the Bash shell by default 
   Other       can be installed using sudo apt-get install utility-name (or   
               yum install for RedHat based systems)                          
               # – requires linux-commands to be executed with root           
               privileges either directly as a root user or by use of sudo    
   Conventions command                                                        
               $ – requires linux-commands to be executed as a regular        
               non-privileged user                                            

   Before we start, please install the 3 utilities using the following
   command (on Ubuntu or Mint), or use yum install instead of apt install if
   you are using a RedHat based Linux distribution.

 $ sudo apt-get install wget curl lynx

     ----------------------------------------------------------------------

     ----------------------------------------------------------------------

   Once done, let’s get started!

Example 1: wget

   Using wget to retrieve a page is easy and straightforward:

 $ wget https://linuxconfig.org/linux-complex-bash-one-liner-examples
 --2020-10-03 15:30:12--  https://linuxconfig.org/linux-complex-bash-one-liner-examples
 Resolving linuxconfig.org (linuxconfig.org)... 2606:4700:20::681a:20d, 2606:4700:20::681a:30d, 2606:4700:20::ac43:4b67, ...
 Connecting to linuxconfig.org (linuxconfig.org)|2606:4700:20::681a:20d|:443... connected.
 HTTP request sent, awaiting response... 200 OK
 Length: unspecified [text/html]
 Saving to: 'linux-complex-bash-one-liner-examples’

 linux-complex-bash-one-liner-examples         [ <=>                                                                                 ]  51.98K  --.-KB/s    in 0.005s 

 2020-10-03 15:30:12 (9.90 MB/s) - 'linux-complex-bash-one-liner-examples’ saved [53229]

 $

   Here we downloaded an article from linuxconfig.org into a file, which by
   default is named the same as the name in the URL.

   Let’s check out the file contents

 $ file linux-complex-bash-one-liner-examples
 linux-complex-bash-one-liner-examples: HTML document, ASCII text, with very long lines, with CRLF, CR, LF line terminators
 $ head -n5 linux-complex-bash-one-liner-examples
 <!DOCTYPE html>
 <html lang="en-gb" dir="ltr">
 <head>
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <meta http-equiv="X-UA-Compatible" content="IE=edge" />

   Great, file (the file classification utility) recognizes the downloaded
   file as HTML, and the head confirms that first 5 lines (-n5) look like
   HTML code, and are text based.

Example 2: curl

 $ curl https://linuxconfig.org/linux-complex-bash-one-liner-examples > linux-complex-bash-one-liner-examples
   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                  Dload  Upload   Total   Spent    Left  Speed
 100 53045    0 53045    0     0  84601      0 --:--:-- --:--:-- --:--:-- 84466
 $

   This time we used curl to do the same as in our first example. By default,
   curl will output to standard out (stdout) and display the HTML page in
   your terminal! Thus, we instead redirect (using >) to the file
   linux-complex-bash-one-liner-examples.

   We again confirm the contents:

 $ file linux-complex-bash-one-liner-examples
 linux-complex-bash-one-liner-examples: HTML document, ASCII text, with very long lines, with CRLF, CR, LF line terminators
 $ head -n5 linux-complex-bash-one-liner-examples
 <!DOCTYPE html>
 <html lang="en-gb" dir="ltr">
 <head>
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <meta http-equiv="X-UA-Compatible" content="IE=edge" />

     ----------------------------------------------------------------------

     ----------------------------------------------------------------------

   Great, the same result!

   One challenge, when we want to process this/these file(s) further, is that
   the format is HTML based. We could parse the output by using sed or awk
   and some semi-complex regular expression, to reduce the output to
   text-only but doing so is somewhat complex and often not sufficiently
   error-proof. Instead, let’s use a tool which was natively
   enabled/programmed to dump pages into text format.

Example 3: lynx

   Lynx is another tool which we can use to retrieve the same page. However,
   unlike wget and curl, lynx is meant to be a full (text-based) browser.
   Thus, if we output from lynx, the output will be text, and not HTML,
   based. We can use the lynx -dump command to output the webpage being
   accessed, instead of starting a fully interactive (test-based) browser in
   your Linux client.

 $ lynx -dump https://linuxconfig.org/linux-complex-bash-one-liner-examples > linux-complex-bash-one-liner-examples
 $

   Let’s examine the contents of the created file once more:

 $ file linux-complex-bash-one-liner-examples
 linux-complex-bash-one-liner-examples: UTF-8 Unicode text
 $ head -n5 linux-complex-bash-one-liner-examples
      * [1]Ubuntu
           +
                o [2]Back
                o [3]Ubuntu 20.04
                o [4]Ubuntu 18.04

   As you can see, this time we have a UTF-8 Unicode text based file, unlike
   the previous wget and curl examples, and the head command confirms that
   the first 5 lines are text based (with references to the URL’s in the form
   of [nr] markers). We can see the URL’s towards the end of the file:

 $ tail -n86 linux-complex-bash-one-liner-examples | head -n3
    Visible links
    1. https://linuxconfig.org/ubuntu
    2. https://linuxconfig.org/linux-complex-bash-one-liner-examples

   Retrieving pages in this way provides us with a great benefit of having
   HTML-free text-based files which we can use to process further if so
   required.

Conclusion

   In this article, we had a short introduction to the wget, curl and lynx
   tools, and we discovered how the latter can be used to retrieve web pages
   in a textual format dropping all HTML content.

   Please, always use the knowledge gained here responsibly: please do not
   overload webservers, and only retrieve public domain, no-copyright, or
   CC-0 etc. data/pages. Also always make sure to check if there is a
   downloadable database/dataset of the data you are interested in, which is
   much preferred to individually retrieving webpages.

   Enjoy your new found knowledge, and, mum, looking forward to that cake for
   which you downloaded the recipe using lynx --dump! If you dive into any of
   the tools further, please leave us a comment with your discoveries.

  Related Linux Tutorials:

     * Big Data Manipulation for Fun and Profit Part 1
     * Big Data Manipulation for Fun and Profit Part 3
     * Big Data Manipulation for Fun and Profit Part 2
     * Curl file download on Linux
     * Wget file download on Linux
     * Download file from URL on Linux using command line
     * Things to install on Ubuntu 20.04
     * How to use curl to get public IP address
     * Things to do after installing Ubuntu 20.04 Focal Fossa Linux
     * How to install Chef Server, Workstation and Chef…
   Categories Programming & Scripting  Tags commands, database, scripting,
   webserver Post navigation
   Big Data Manipulation for Fun and Profit Part 2
   Bash Background Process Management

     ----------------------------------------------------------------------

     ----------------------------------------------------------------------

                            Comments and Discussions
                                  Linux Forum

     ----------------------------------------------------------------------

  NEWSLETTER

   Subscribe to Linux Career Newsletter to receive latest news, jobs, career
   advice and featured configuration tutorials.

   SUBSCRIBE

  WRITE FOR US

   LinuxConfig is looking for a technical writer(s) geared towards GNU/Linux
   and FLOSS technologies. Your articles will feature various GNU/Linux
   configuration tutorials and FLOSS technologies used in combination with
   GNU/Linux operating system.

   When writing your articles you will be expected to be able to keep up with
   a technological advancement regarding the above mentioned technical area
   of expertise. You will work independently and be able to produce at
   minimum 2 technical articles a month.

   APPLY NOW

  CONTACT US

   web ( at ) linuxconfig ( dot ) org

TAGS

   18.04 administration apache applications bash beginner browser centos
   centos8 commands database debian desktop development docker fedora
   filesystem firewall gaming gnome Hardware installation java kali manjaro
   multimedia networking nvidia programming python redhat rhel rhel8
   scripting security server ssh storage terminal ubuntu ubuntu 20.04 video
   virtualization webapp webserver

  FEATURED TUTORIALS

     * How to install the NVIDIA drivers on Ubuntu 20.04 Focal Fossa Linux
     * Bash Scripting Tutorial for Beginners
     * How to check CentOS version
     * How to find my IP address on Ubuntu 20.04 Focal Fossa Linux
     * Ubuntu 20.04 Remote Desktop Access from Windows 10
     * Howto mount USB drive in Linux
     * How to install missing ifconfig command on Debian Linux
     * AMD Radeon Ubuntu 20.04 Driver Installation
     * Ubuntu Static IP configuration
     * How to use bash array in a shell script
     * Linux IP forwarding – How to Disable/Enable
     * How to install Tweak Tool on Ubuntu 20.04 LTS Focal Fossa Linux
     * How to enable/disable firewall on Ubuntu 18.04 Bionic Beaver Linux
     * Netplan static IP on Ubuntu configuration
     * How to change from default to alternative Python version on Debian
       Linux
     * Set Kali root password and enable root login
     * How to Install Adobe Acrobat Reader on Ubuntu 20.04 Focal Fossa Linux
     * How to install the NVIDIA drivers on Ubuntu 18.04 Bionic Beaver Linux
     * How to check NVIDIA driver version on your Linux system
     * Nvidia RTX 3080 Ethereum Hashrate and Mining Overclock settings on
       HiveOS Linux

  LATEST TUTORIALS

     * How to perform administration operations with Ansible modules
     * Introduction to Wake On Lan
     * Introduction to YAML with Examples
     * Hardening Kali Linux
     * How to manipulate Excel spreadsheets with Python and openpyxl
     * Ubuntu 22.04 Features and Release Date
     * Ubuntu 22.04 Download
     * How To Upgrade Ubuntu To 22.04 LTS Jammy Jellyfish
     * Ansible loops examples and introduction
     * How to use and install Rofi on Linux tutorial
     * How to manage wireless connections using iwd on Linux
     * Regain your Privacy and Security in Digital Era
     * How to install Telegram on Linux
     * Linux commands cheat sheet
     * How to migrate Apache to Nginx by converting VirtualHosts to Server
       Blocks
     * How to tune Linux extended (ext) filesystems using dumpe2fs and
       tune2fs
     * SQLite Linux Tutorial for Beginners
     * VirtualBox increase disk size on Linux
     * wipefs Linux command tutorial with examples
     * Megatools Linux install and Basic Introduction
   © 2021 TOSID Group Pty Ltd - LinuxConfig.org
   Close
     * Linux Tutorials
     * System Admin
     * Programming
     * Multimedia
     * Forum
     * Linux Commands
     * Linux Jobs
