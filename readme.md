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


And create your work log, a YAML list of work log items keyed by date.

`ex. work-log.yaml`

```yaml
3/29/2013:

  - project: PROJECT-ID
    hours: 2
    comments: >
      Some comments

  - project: ANOTHER-PROJECT-ID
    hours: 3
    comments: >
      Some more comments

3/30/2013:

  - project: PROJECT-ID
    hours: 2
    comments: >
      Some comments

  - project: ANOTHER-PROJECT-ID
    hours: 3
    comments: >
      Some more comments

4/1/2013:

  - project: PROJECT-1-ID
    hours: 2
    comments: >
      Some comments

  - project: PROJECT-2-ID
    startTime: 8:30 am
    endTime: 9:30 am
    comments: >
      Some more comments

  - project: PROJECT-3-ID
    worklog:
      -
        startTime: 9:30 am
        endTime: 10:30 am
        comments: >
          Work log 1 comment
      -
        hours: 2
        comments: >
          Work log 2 comment
    comments: >
      Project 3 comment
```

Notice that the work log is a list of date blocks and each date block contains
a list of project work log items.

And run tempo-tantrum with your work log

```bash
$ tempo-tantrum -w le-work-log
```

OR run it without a filename for interactive mode!

```bash
$: ./tempo-tantrum
Entering interactive mode
Date (ex. 4/9/2013): 4/16/2013
Enter work log
Project: PROJECT-ID
Hours: 1
Comments: Some stuff
All done, go get a cup of coffee
```

Note that tempo-tantrum is **not** stateful **nor** idempotent therefore you should
be probably run tempo-tantrum with a fresh log each time.

### Requirements

Ruby, cURL
