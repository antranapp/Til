# Til: Today I Learned

Til is a command line tool written in `Swift` to manage a `Today-I-Learned` repository.

## 😯 What is a Today-I-Leanred (Til) repository?

If you don't know what what "Today I Learned" is, then lmgtfy :D

A til repository is kind a place to store things you have learned or read or stumbled upon.

With a repository, you can go back in time and search for something that you know for sure you have seen before but probably can't find it again, such as in Google.

This movement has been adopted also by many organisations to provide a bite size information to their audiences, such as:
- [National Geographic TIL](https://video.nationalgeographic.com/video/til)
- [Reddit](https://www.reddit.com/r/todayilearned/)
- ...

## 💻 TIL in software development context

In Software development, we collect over the time so many code snippet, tips, tricks for our jobs. But it is not an easy task to manage such information so that you can easily find them again.

It's also not so easy to share such information with others if you only save them locally on your computers.

## 😲 I'm sold, so what is this tool?

I've accidently found[ this discussion in Hacker News](https://news.ycombinator.com/item?id=22908044) about a guy who have been managing [his TIL repository](https://github.com/jbranchaud/til) for over 5 years

His TIL repository is full of interesting and useful information.

Then I take look in github, [the `til` topic](https://github.com/topics/til) is full of interesting repositories.

I'm totally convinced by the idea and also starting to create [a TIL repository for myself](https://github.com/antranapp/today-i-learned): 

But after some days, I find it is hard to mange it, and also to find the snippet that I'm looking for again.

So I have started to build a command-line tool to help me managing this TIL respository more easily.

The command line tool can basically:

- Add a new topic, create a markdown file with some pre-filled meta data and open a markdown editor for you to add information
- Generate a README.md by aggregating all Tils in the repo and list them in a table view organized by topics.
- Deploy all changes to the remote repository.

## 😭 Oh no, why Swift?

Sorry, I'm [iOS developer](https://antran.app).

You should actually try [Swift](https://swift.org/). It is a relatively easy to learn and powerful programming language.

## 🤯 What is the future plan?

Some ideas I have in mind now:

- A command create a static website so that we can display the tils in Github Pages and also add some Full-Text-Search to that. 
- A command to create a PDF from a remote site and attach it to the til to preventing the information going away when the remote sites are not reachable or changed.

There are some similar tools already existed if you want some alternatives:

- An electron app: [https://github.com/seokju-na/geeks-diary](https://github.com/seokju-na/geeks-diary)
- Using Github issues for tils (👌👍): [https://github.com/tieubao/til/issues](https://github.com/tieubao/til/issues)
- A VSCode extension: [https://github.com/rahuldhawani/TILed](https://github.com/rahuldhawani/TILed)

If you have any interesting ideas, please tell me what you want to add by creating new issues or new PRs
