---
id: 73
layout: post
title: >
    Book Review: Perl Testing : A Developer's Notebook
---

<a href="http://www.amazon.com/gp/product/0596100922">0596100922</a>

The Perl Testing Developer's Notebook is a one stop source of information on perl testing. Its concise and easy to read style is great for developers of all levels of expertise.<br /><br />

When reading this book, you should keep in mind that it is really divided into two major sections. The first covers what tests are, how to use them and where to get started. The second section goes in depth to cover more specific examples of testing and how you can easily implement tests in your applications.<br /><br />

The first and second chapters work well together by talking about what testing is and what it can be used for. It covers the installation and usage of test modules as well as writing basic and somewhat complex tests. The second chapter also goes over deep structure testing and tests diffs. The third chapter expands upon chapter 2 by discussing test management and coverage testing.<br /><br />

Chapter four tries to cover everything that wasn't covered in chapters one, two and three. This chapter ranges in subjects from pod and pod coverage testing, distribution test and signatures, result collection and module polishing with Kwalitee.<br /><br />

At chapter five the seperation between sections makes itself clear. This chapter starts to get deeper on specific testing cases and examples of code  overrides and mocking.

Chapters six and seven seem to go hand and hand as one reviews database and data set testing and the other covers website and backend testing. I really appreciate the ideas that chapter six presents about database and data set testing. It doesn't just stop at testing connections and such but also goes into mock databases, temporary databases and writing wrappers for extending testing.<br /><br />

Chapter seven goes into testing websites in the same fashion that chapter six covers testing databases. My only gripe is that it doesn't go too deeply into backend testing. The frontend testing is fairly comprehensive and it gives a lot of example on using WWW::Mechanize and other toolkits to efficiently recreate user experience. It also talks lightly about page validation. Toward the end of the chapter it gives a lot of detail on running a test server using Apache::Test and being able to really localize all of your web server and page testing. This is great because it allows you to do basic load and resource testing as well as keeping all of the build and testing of a web service completely separate from production areas.<br /><br />

Chapter 8 tries to cover object oriented testing with Test::Class. This is a relatively different way of testing compared to the styles and standards presented in Test::Simple or Test::More. This presents some very interesting views on object and class testing inheritance.<br /><br />

Chapter 9 cleans up by discussing practical ideas on writing testable code and programs. One thing that I found nice was that it touched shared library testing and interactive program testing.<br /><br />

I find this book very useful because of its practical example and reinforcement of good testing standards. It has become a solid reference for quick tips on test unit creation, testing methods in general, and test coverage testing. I recommend it for anyone who is looking to start working with more focused testing or want to expanding there current testing knowledge in general.<br /><br />


Table of Contents <br />
Chapter 1. Beginning Testing<br />
 + Installing Test Modules<br />
 + Running Tests<br />
 + Interpreting Test Results<br />
 + Writing Your First Test<br />
 + Loading Modules<br />
 + Improving Test Comparisons<br />
Chapter 2. Writing Tests<br />
 + Skipping Tests<br />
 + Skipping All Tests<br />
 + Marking Tests as TODO<br />
 + Simple Data Structure Equality<br />
 + Data Composition<br />
 + Testing Warnings<br />
 + Testing Exceptions<br />
Chapter 3. Managing Tests<br />
 + Organizing Tests<br />
 + Checking your Coverage<br />
 + Writing a Testing Library<br />
 + Testing a Testing Library<br />
 + Writing a Testing Harness<br />
 + Testing Across your Network<br />
 + Automating Test Runs<br />
Chapter 4. Distributing your Tests ( and Code )<br />
 + Testing POD Files<br />
 + Testing Documentation Coverage<br />
 + Distribution Signatures<br />
 + Testing Entire Distributions<br />
 + Letting the User Decide<br />
 + Bundling Tests with Modules<br />
 + Collecting Test Results<br />
 + Validating Kwalitee<br />
Chapter 5. Testing Untestable Code<br />
 + Overriding Built-ins<br />
 + Mocking Modules<br />
 + Mocking Objects<br />
 + Partially Mocking Objects<br />
 + Overriding Live Code<br />
 + Overriding Operators Everywhere<br />
Chapter 6. Testing Databases<br />
 + Shipping Test Databases<br />
 + Testing Database Data<br />
 + Using Temporary Data<br />
 + Mocking Databases<br />
Chapter 7. Testing Web Sites<br />
 + Testing your Backend<br />
 + Testing your Frontend<br />
 + Record and Play Back Browsing Sessions<br />
 + Testing the Validity of HTML<br />
 + Running Your Own Apache Server<br />
 + Testing with Apache-Test<br />
 + Distributing Modules with Apache-Test<br />
Chapter 8. Unit Testing with Test::Class<br />
 + Writing Test Cases<br />
 + Creating Test Fixtures<br />
 + Inheriting Test Fixtures<br />
 + Skipping Tests with Test::Class<br />
 + Marking Tests as TODO with Test::Class<br />
Chapter 9. Testing Everything Else<br />
 + Writing Testable Programs<br />
 + Testing Programs<br />
 + Testing Interactive Programs<br />
 + Testing Shared Libraries
