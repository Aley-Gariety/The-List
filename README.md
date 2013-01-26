## Welcome to The List


## FAQ


*   Q: What makes The List different from sites like Hacker News, Reddit, and Digg?
*   Unlike other sites of its kind, a user's ability to post to The List is determined by their karma on the website relative to the traffic the site each day. This is different from the "post as much as you want" methodology present on sites like Hacker News, Reddit, and Digg. That methodology results in what is called the "tragedy of the commons". This term, often used in economics, describes a situation in which many people with their own interests in mind, sharing a resource together, causes the quality of the resource to deteriorate over time as more people use it. This happens because it is in each user's best interest to use the network as much as possible. By privatizing the ability to post with a karma price-tag and weighting a post's rank on the list with some simple calculus,a board of ideas and links can thrive where quality does not deteriorate with quantity.
*   Q: How do I get onto The List?
*   You need to receive an invite from another member. Then you can submit URLs.
*   Q: Why does it cost karma to post?
*   This is part of quality control. We incentivize submitting only quality content by privatizing The List as a resource. You can gain karma by posting things people like.
*   Q: Why are there no images on The List?
*   The List is also aware of the tragedy of quick consumption. In other words, the problem that content that can be quickly read (or "consumed") and up-voted makes its way to the front page fastest. If The List displayed thumbnails of the sites they showed, we put quality content at risk if we can't find a thumbnail for it.
*   Q: What is with the commenting system?
*   Part of the list is ensuring all content is quality, we think this should include commenting as well. We've taken cues from [Branch][1] in building our comment system so that conversations can flow as if you were sitting at a dinner table. Though you can't reply directly to a comment, you can quote all or some of a previous user's comment.

## Under the Hood

The List sports a set of "rules" that help automatically curate the order of the list for quality:

*   Cost of posting:
*   Posting costs 2% of the poster's total karma with a minimum of 10. New posts start out with the karma it cost to post them.
*   Casting votes:
*   A vote is worth 2% of your total karma with a minimum of 1. Voting doesn't cost any of your own like posting and gifting do, it only adds to the post's score.
*   Cost of gifting:
*   Gifting takes however much of your karma you're willing to give up with a minimum of 10.
*   Ranking algorithm:
*   The list uses a ranking algorithm similar to the one used by Reddit.com, with a few adjustments. In essence, a post's rank is determined by three factors: how much karma it has received form its voters, how fast its discussion is moving, and how recently it was created. We use this exact SQL query:

        [TOTAL KARMA] = upvote karma - downvote karma + total discussion karma

              log10(abs([TOTAL KARMA]) + 1) * sign([TOTAL KARMA]) + (unix_timestamp([CREATED AT]) / 300000) DESC



## Technologies

The List runs on the flexible, [Ruby programming language][2] and it's powerful, rapid-development framework, [Rails][3]. This was a choice made by the developers to ensure the speed and stability of the web app.

## Foundation

The List was designed with the same methodology as an addictive video game. The balance between user's, posts, and karma is one of the most well-thought-out elements of the application. On the surface, the site is minimal, but under the hood it sports an array of mass-relative algorithms to show the best posts first and keep poor quality content off of The List.

## Interface

The List was designed to be minimal so that user's wouldn't be intimidated by the complexity of it's engine. With great power comes a great responsibility to simplify. Nothing on The List is hidden, it's all shown to you on every page of the website. It should always be clear the user where to go to perform a task on the website.

## Source code, bug reporting & coming features

All information about coming features and bug reporting as well as the entire source code for The List can be found in [this GitHub repo][4].

 [1]: http://branch.com/
 [2]: http://www.ruby-lang.org
 [3]: http://rubyonrails.org
 [4]: http://github.com/jacksonGariety/The-List/