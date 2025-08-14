from emailrep import EmailRep

import os

# setup your api key (optional)
emailrep = EmailRep(os.getenv("EMAILREP_API_KEY"))

# query an email address
emailrep.query("bill@microsoft.com")

# report an email address (key required)
emailrep.report("foo@bar.com", ["bec", "maldoc"], "Phishing email targeting CEO")
