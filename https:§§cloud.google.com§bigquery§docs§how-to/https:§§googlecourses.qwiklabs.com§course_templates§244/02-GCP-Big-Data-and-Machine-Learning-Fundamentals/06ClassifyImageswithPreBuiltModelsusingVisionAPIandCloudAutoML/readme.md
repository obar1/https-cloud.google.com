# 06ClassifyImageswithPreBuiltModelsusingVisionAPIandCloudAutoML

## Where is Unstructured ML used in business?

![](2020-11-01-16-12-23.png)

create model 

![](2020-11-01-16-13-57.png)

add label to image

def caption on what is in the img

![](2020-11-01-16-14-26.png)


## How Does ML on Unstructured Data Work?

how ml learn from unstructured data

![](2020-11-01-16-15-35.png)
ex no rule can describe this
how do we know that is a cat?

![](2020-11-01-16-16-12.png)
rules fail here

you need to give to the NN a loads of images of cats to train it

![](2020-11-01-16-17-12.png)
NN/Deep learning inspired by out brain
it builds internal recipe to categorize

use deeplearning when we cannot label ourself the example and looking for answer/categorization

## Demo - ML built into Google Photos

google photo uses internally to categorize what is in a photo
uses `vision api`


## Comparing Approaches to ML

we have 3 approaches:

![](2020-11-01-16-21-04.png)

when you have 100+ to millions of example use `create custom model` but if they are less use `prebuilt ai`
chatbot uses dialogflow
if the building block does not work well use `automl` 

![](2020-11-01-16-22-47.png)
as service
less complex to use as they are prebuilt
- cloud speech-to-text convert audio to text for data processing 
- cloud natural language api recognizes parts of speech called entities and sentiment
- cloud translation converts text in one language to another 
- dialogue flow to build chat BOTS to conduct conversations 
- cloud text-to-speech converts text into high-quality voice audio 
- cloud vision API is for working with and recognizing content in still images 
- cloud video intelligence API is for recognizing emotions and action in video

you need 100k samples to train a forecast model

## Demo - Using ML Building Blocks

// cloud translation 

![](2020-11-01-16-40-48.png)
the api

![](2020-11-01-16-41-25.png)
use api in google sheets

// vision api
label detection
detect face in img and emotional 
ocr and extract text
explicit contents  like violent and adult
landmark detection
logo in a img


![](2020-11-01-16-42-31.png)
ex of `json` result and attributes for each result

![](2020-11-01-16-42-56.png)
harry potter car 

try it https://cloud.google.com/vision an upload imgs

use ocr and translate https://cloud.google.com/translate
https://www.wootric.com/
prioritize customer feedback

![](2020-11-01-16-45-01.png)
magnitude

![](2020-11-01-16-45-23.png)
video intelligence api to label and when they occurred and confidence level

https://cloud.google.com/video-intelligence


# Using Pre-built AI to Create a Chatbot

use chatbot on top  existing solution

![](2020-11-01-16-46-43.png)
talk with someone 
automation to scale

![](2020-11-01-16-47-06.png)
platform to  built rich conversational exp
powerful natural language engine to process text

https://cloud.google.com/dialogflow

it recognizes entities
it has sentiment analysis for a block of text
classify documents about theta they are

![](2020-11-01-16-49-13.png)
agent learn from interaction with users

![](2020-11-01-16-49-55.png)
use out of the box or import in your custom agent

![](2020-11-01-16-50-40.png)
how users are using their time with the agent


## Customizing Pre-built Models with AutoML

![](2020-11-01-16-51-51.png)
build ml-model with aut-ml // no code required

![](2020-11-01-16-52-26.png)
train model with classes and examples

![](2020-11-01-16-52-51.png)
1 compute hour for free for training

![](2020-11-01-16-53-05.png)
mdeol trained

![](2020-11-01-16-53-14.png)
evaluate the model

prevision = measure about quality
recall = measure of the quantity 

use `confusion matrix` to evaluate the model
![](2020-11-01-17-27-29.png)

one has some issues as percentual is low

all these steps are gone with automl
![](2020-11-01-17-28-33.png)

![](2020-11-01-17-28-42.png)
multiple models are created and compared

![](2020-11-01-17-29-04.png)
y is accuracy 

![](2020-11-01-17-29-34.png)
recap
auto ml is good for classification on img you provide


## Demo - Text Classification Done Three Ways

we can solve a problem using 3 approach
big query ml
aut ml
custom model ml

> given some text can you say where it was copied from

![](2020-11-01-17-32-29.png)

### use big query

`hacker new stories` from public data set

TODO: check the dataset

![](2020-11-01-17-33-03.png)
5 words

train ml model giving it as input

![](2020-11-01-17-33-49.png)

![](2020-11-01-17-34-11.png)
model is `logistic regression` and label is `source`

we have then a new model that is trained in big query


![](2020-11-01-17-34-47.png)

check accuracy from the result

![](2020-11-01-17-35-42.png)
let's test on some input with `ml.predict`


### use auto ml

![](2020-11-01-17-36-35.png)

![](2020-11-01-17-36-42.png)
load dataset 100k articles with label

![](2020-11-01-17-37-06.png)
train the model // few hours

![](2020-11-01-17-37-13.png)
check the confusion matrix

![](2020-11-01-17-37-54.png)
test with predict


### write custom model

> use notebook

https://github.com/GoogleCloudPlatform/training-data-analyst

![](2020-11-01-17-38-43.png)

![](2020-11-01-17-39-05.png)

change bucket using your project id


![](2020-11-01-17-41-39.png)
jupiter magic to run bigquery // as done before

![](2020-11-01-17-42-22.png)
traindf and evaldf // 75% and 25%

![](2020-11-01-17-42-53.png)

use tensorflow or keras for ml models

![](2020-11-01-17-43-39.png)
submit to ml engine







