![Tempo Tantrum](http://sht.tl/cMa0 "Tempo Tantrum")

## Tempo Tantrum

Hate updating Tempo manually? Of course you do. Use Tempo Tantrum instead and
update your time tracking in batches with a simple text file containing your
work log.

### Usage

Update `~/.tempo-tantrum` with your Jira configuration

`ex. ~/.tempo-tantrum config`


    jira location: https://jira-host
    user: user
    pass: pass


`ex. work-log.txt_`

    03/27/2013

      comment: text
      issue: SAPTESTDRIVE-23
      time: 5


And run tempo-tantrum with your work log

$ tempo-tantrum le-work-log

Note that tempo-tantrum is **not** stateful **nor** idempotent therefore you should
be probably run tempo-tantrum with a fresh log each time.

### Requirements

Ruby, cURL
