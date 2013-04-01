### Tempo Tantrum

![Tempo Tantrum](http://sht.tl/1Ezu "Tempo Tantrum")

Hate updating Tempo manually? Of course you do. Use Tempo Tantrum instead and
update your time tracking in batches with a simple text file containing your
work log.

### Usage

Update ~/.tempo-tantrum with your Jira configuration

_ex. ~/.tempo-tantrum config_


  jira location: https://jira-host
  user: user
  pass: pass


_ex. work-log.txt_

  03/27/2013

    comment: text
    issue: SAPTESTDRIVE-23
    time: 5


<< config info .>>

Then run tempo-tantrum with your work log

$ tempo-tantrum le-work-log

Note that tempo-tantrum is *not* stateful *nor* idempotent therefore you should
be probably run tempo-tantrum with a fresh log each time.

### Requirements

Ruby, cURL
