# Oystercard

**Week 2 Challenge at Makers Academy**: Tasked to build a Oystecard system to further enforce OOP and TDD practices learnt in week 1.

## Getting Started
The instructions below will get you a copy of the project up and running on your local machine for development and testing purposes.
1. Clone the repository to your system
2. Redirect into the parent directory `cd oystercard`
3. Run IRB or and another Ruby REPL
4. Load in the files stored in the lib directory: journey_log.rb, journey.rb, oystercard.rb, station.rb to get started `ie. require './lib/station.rb'`


## Testing
Tests were designed and run using the RSpec framework.

To install the RSpec gem:
`gem install rspec` or `bundle`

To run RSpec tests:
`rspec`

## Features
* Oystercard
* Docking station
* Garage
* Van

## User stories
Please see inside docs folder for user stories





|    Objects   | Messages |
| ------------ | ----------- |
|   Customer   |             |
|   oyster     |  top_up, limit_reached?, minimum?, trips  |
|   Station   |  enter(oyster), exit(oyster)     |

```
In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to protect my money from theft or loss
As a customer
I want a maximum limit (of £90) on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers
As a customer
I need to touch in and out

In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

In order to pay for my journey
As a customer
I need to know where I've travelled from

In order to know where I have been
As a customer
I want to see to all my previous trips

In order to know how far I have travelled
As a customer
I want to know what zone a station is in

In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated
```
