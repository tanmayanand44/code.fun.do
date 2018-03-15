#!/bin/bash

#Find trending hashtags
python TrendingHashtags.py >| hashtags.txt

#Downloading the tweets
# echo Downloading tweets
# rm -rf crawl_tweets
# mkdir crawl_tweets
# python crawl.py hashtags.txt crawl_tweets/
# find crawl_tweets/ -size 0 -type f -delete



#Clean the tweets
echo Cleaning tweets
rm -rf clean_tweets
mkdir clean_tweets
python clean.py crawl_tweets/ clean_tweets/

#Tag the tweets.
echo Tagging tweets
rm -rf process_tweets
mkdir process_tweets
python tag.py clean_tweets/ process_tweets/

#Generate the summary of the files.
echo Summarizing tweets
 for i in $(ls clean_tweets/); do
    rm -rf summary
    mkdir summary
    summary="/summary/"
    working_dir=$(pwd)
    process_tweets="/process_tweets/"
    clean_tweets="/clean_tweets/"
    suffix="_features"
    file="$working_dir$clean_tweets"$i""
    feature="$working_dir$process_tweets"$i"$suffix"
    python tweet_summarizer.py "$file" "$feature" > $working_dir$summary"$i"
done

echo DONE!