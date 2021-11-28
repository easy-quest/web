Retrieving Webpages Using wget, curl and lynx
===

```
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
 ```html
 <!DOCTYPE html>
 <html lang="en-gb" dir="ltr">
 <head>
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <meta http-equiv="X-UA-Compatible" content="IE=edge" />
```
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
 ```
head -n5 linux-complex-bash-one-liner-examples
```
```html
 <!DOCTYPE html>
 <html lang="en-gb" dir="ltr">
 <head>
 <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <meta http-equiv="X-UA-Compatible" content="IE=edge" />
```



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

