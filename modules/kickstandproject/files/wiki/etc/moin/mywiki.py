from farmconfig import FarmConfig
from MoinMoin.auth.openidrp import OpenIDAuth


class Config(FarmConfig):

    acl_rights_default = u'Known:read,write,delete,revert All:read'
    auth = [OpenIDAuth(forced_service='https://login.launchpad.net/+openid')]
    cookie_lifetime = (2, 12)
    data_dir = '/usr/share/moin/data'
    data_underlay_dir = '/usr/share/moin/underlay'
    interwikiname = u'MyWiki'
    page_front_page = u"FrontPage"
    sitename = u'MyWiki'
