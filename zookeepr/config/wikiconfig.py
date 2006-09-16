# -*- coding: iso-8859-1 -*-
# IMPORTANT! This encoding (charset) setting MUST be correct! If you live in a
# western country and you don't know that you use utf-8, you probably want to
# use iso-8859-1 (or some other iso charset). If you use utf-8 (a Unicode
# encoding) you MUST use: coding: utf-8
# That setting must match the encoding your editor uses when you modify the
# settings below. If it does not, special non-ASCII chars will be wrong.

"""
    MoinMoin - Configuration for a single wiki

    If you run a single wiki only, you can omit the farmconfig.py config
    file and just use wikiconfig.py - it will be used for every request
    we get in that case.

    Note that there are more config options than you'll find in
    the version of this file that is installed by default; see
    the module MoinMoin.multiconfig for a full list of names and their
    default values.

    Also, the URL http://moinmoin.wikiwikiweb.de/HelpOnConfiguration has
    a list of config options.

    ** Please do not use this file for a wiki farm. Use the sample file 
    from the wikifarm directory instead! **
"""

from MoinMoin.multiconfig import DefaultConfig
from paste.deploy import CONFIG

from MoinMoin.auth import http

class Config(DefaultConfig):

    auth = [http]
    user_autocreate = True

    # Wiki identity ----------------------------------------------------

    # Site name, used by default for wiki name-logo [Unicode]
    sitename = u'MyLCA Wiki'

    # Wiki logo. You can use an image, text or both. [Unicode]
    # For no logo or text, use '' - the default is to show the sitename.
    # See also url_prefix setting below!
    logo_string = u'<img src="/wiki/common/moinmoin.png" alt="MoinMoin Logo">'

    # name of entry page / front page [Unicode], choose one of those:

    # a) if most wiki content is in a single language
    #page_front_page = u"MyStartingPage"

    # b) if wiki content is maintained in many languages
    #page_front_page = u"FrontPage"

    # The interwiki name used in interwiki links
    #interwikiname = 'UntitledWiki'
    # Show the interwiki name (and link it to page_front_page) in the Theme,
    # nice for farm setups or when your logo does not show the wiki's name.
    #show_interwiki = 1


    # Critical setup  ---------------------------------------------------

    # Misconfiguration here will render your wiki unusable. Check that
    # all directories are accessible by the web server or moin server.

    # If you encounter problems, try to set data_dir and data_underlay_dir
    # to absolute paths.

    # Where your mutable wiki pages are. You want to make regular
    # backups of this directory.
    data_dir = CONFIG['app_conf']['moin_data']

    # Where read-only system and help page are. You might want to share
    # this directory between several wikis. When you update MoinMoin,
    # you can safely replace the underlay directory with a new one. This
    # directory is part of MoinMoin distribution, you don't have to
    # backup it.
    data_underlay_dir = CONFIG['app_conf']['moin_underlay']

    # Location of your STATIC files (css/png/js/...) - you must NOT use the
    # same for invoking moin.cgi (or, in general, the moin code).
    # url_prefix must be '/wiki' for Twisted and standalone servers.
    # For CGI, it should match your Apache Alias setting.
    url_prefix = '/wiki'


    # Security ----------------------------------------------------------

    # This is checked by some rather critical and potentially harmful actions,
    # like despam or PackageInstaller action:
    #superuser = [u"YourName", ]

    # IMPORTANT: grant yourself admin rights! replace YourName with
    # your user name. See HelpOnAccessControlLists for more help.
    # All acl_rights_xxx options must use unicode [Unicode]
    acl_rights_default = u"Trusted:read,write,delete,revert \
      Known:read,write,delete,revert \
      All:read"
    acl_rights_before = u"Ycros:read,write,delete,revert,admin"

    # Link spam protection for public wikis (Uncomment to enable)
    # Needs a reliable internet connection.
    #from MoinMoin.util.antispam import SecurityPolicy


    # Mail --------------------------------------------------------------

    # Configure to enable subscribing to pages (disabled by default)
    # or sending forgotten passwords.

    # SMTP server, e.g. "mail.provider.com" (None to disable mail)
    #mail_smarthost = ""

    # The return address, e.g u"J�rgen Wiki <noreply@mywiki.org>" [Unicode]
    #mail_from = u""

    # "user pwd" if you need to use SMTP AUTH
    #mail_login = ""


    # User interface ----------------------------------------------------

    # Add your wikis important pages at the end. It is not recommended to
    # remove the default links.  Leave room for user links - don't use
    # more than 6 short items.
    # You MUST use Unicode strings here, but you need not use localized
    # page names for system and help pages, those will be used automatically
    # according to the user selected language. [Unicode]
    navi_bar = [
        # If you want to show your page_front_page here:
        #u'%(page_front_page)s',
        u'RecentChanges',
        u'FindPage',
        u'HelpContents',
    ]

    # The default theme anonymous or new users get
    theme_default = 'zookeepr'


    # Language options --------------------------------------------------

    # See http://moinmoin.wikiwikiweb.de/ConfigMarket for configuration in 
    # YOUR language that other people contributed.

    # The main wiki language, set the direction of the wiki pages
    language_default = 'en'

    # You must use Unicode strings here [Unicode]
    page_category_regex = u'^Category[A-Z]'
    page_dict_regex = u'[a-z]Dict$'
    page_form_regex = u'[a-z]Form$'
    page_group_regex = u'[a-z]Group$'
    page_template_regex = u'[a-z]Template$'

    # Content options ---------------------------------------------------

    # Show users hostnames in RecentChanges
    show_hosts = 1                  

    # Enable graphical charts, requires gdchart.
    #chart_options = {'width': 600, 'height': 300}
