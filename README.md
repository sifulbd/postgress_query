## #1 What is PostgreSQL?

PostgreSQL হচ্ছে বিশ্বের সবচেয়ে উন্নত ওপেন-সোর্স, অবজেক্ট-রিলেশনাল ডাটাবেস। এটি তৈরি করা হয়েছে এন্টারপ্রাইজ-লেভেলের পারফরম্যান্সের জন্য এবং এর শক্তিশালী ফিচার ও নির্ভরযোগ্যতার কারণে এটি ব্যাপকভাবে মূল্যায়িত। একটি রিলেশনাল ডাটাবেস তথ্য সংরক্ষণ করে সুশৃঙ্খল টেবিলের মধ্যে যেখানে row এবং column অনুযায়ী তথ্য থাকে এবং বিভিন্ন টেবিলের মধ্যে সম্পর্কযুক্ত তথ্য সংরক্ষণ করে query এর মাধ্যমে। একটি query হচ্ছে একক একটি অপারেশন যা ডাটাবেস থেকে তথ্য আনে এবং এটি এক বা একাধিক অপারেশনের মাধ্যমে ডাটাবেসে তথ্য দেখা , নতুন করে তৈরি করা , মুছে ফেলা এবং পরিবর্তন করতে পারে। ডাটাবেসে মূল তথ্য সংরক্ষণের অপারেশনগুলোকে সাধারণত CRUD বলা হয়, যার মানে: চ্রেয়াতে বা তৈরি করা, read বা পড়া, update পরিবর্তন করা এবং ডিলিট বা মুছে ফেলা।

তথ্য দ্রুত খুঁজে পাওয়ার জন্য PostgreSQL ব্যবহার করে ইনডেক্স। যা মূল টেবিলের কিছু অংশের একটি অনুলিপি, যেটি পুনরায় সংগঠিত করা হয় দ্রুত সার্চের সুবিধার্থে।

একটি রিলেশনাল ডাটাবেস হিসেবে, PostgreSQL ডেটার গঠন বর্ণনা করতে schema ব্যবহার করে। একটি schema মূলত টেবিল, ইনডেক্স , এবং ফাংশনের একটি সংগ্রহ, এবং PostgreSQL একাধিক schema সাপোর্ট করে ।

## #2 What is the purpose of a database schema in PostgreSQL?

### PostgreSQL এ Schema কী?

PostgreSQL এ Schema হলো লজিক্যাল স্ট্রাকচারস ডাটা। মূলত এটি হলো টেবিলস, ভিউস, ফাংশন্স , কন্সট্রেইন্টস, ইন্দেক্সেস ইত্যাদি এর কালেকশন । তবে, প্রতিটি schema শুধুমাত্র একটি database এর অধীনে থাকে।

### স্কিমার উদ্দেশ্য কী?

Schema ব্যবহারের আগে বুঝে নেওয়া জরুরি যে এর উদ্দেশ্য আসলে কী। PostgreSQL-এর গঠন কাঠামো কিছুটা নিচের মতঃ

-   ইন্টেন্স (Instance)
-   ডাটাবেজ (Database)
-   স্কিমা (Schema)
-   টেবিল (Table)
-   রো (Raw)  
    Instance হলো PostgreSQL চালু করার পর শুরু হওয়া একটি সার্ভার প্রসেস।এর ভেতরে থাকে এক বা একাধিক Database, যেটি ক্লায়েন্ট অ্যাপ্লিকেশনকে সাধারণত কানেক্ট করে। একটি Schema হল Database এর ভেতরে একটি লজিক্যাল লেয়ার, যেটি Table এবং অন্যান্য অবজেক্টের সংগঠক।
    Schema ব্যবহার করে টেবিলগুলোকে একটি গ্রুপে ভাগ করে নেওয়া যায়। ধরুন, আপনার ডাটাবেসে ৫০০টি টেবিল আছে সবগুলো একসাথে রাখলে তা খুবই বিশৃঙ্খল এবং মাইন্ট্যাইন কঠিন হবে। কিন্তু যদি আপনি ১০টি Schema তৈরি করে প্রতিটিতে ৫০টি করে Table রাখেন, তাহলে তা অনেক বেশি ক্লিন ও ব্যবহার করতে সহজ হবে।

### Schema তৈরি করার পদ্ধতি

নতুন একটি Schema তৈরি করতে নিচের CREATE SCHEMA স্টেটমেন্ট ব্যবহার করা হয়:

```sql
    CREATE SCHEMA [IF NOT EXISTS] schema_name;
```

এখানে IF NOT EXISTS দিলে PostgreSQL প্রথমে চেক করে Schema আগে থেকেই আছে কিনা। থাকলে কোনো error না দেখিয়ে চুপচাপ কাজ থামিয়ে দেয়।

## #3 What is the difference between the VARCHAR and CHAR data types?

CHAR হলো fixed size ডেটা টাইপ, আর VARCHAR হলো variable size ডেটা টাইপ।
CHAR ডেটা টাইপে ডেটা সবসময় নির্দিষ্ট লেংথ(length) সংরক্ষণ করা হয় যেমন: আপনি যদি CHAR(10) দেন এবং "abc" লিখেন, তাহলে PostgreSQL সেটিকে "abc " অর্থাৎ শেষে ৭টি স্পেস(space) যোগ করে সংরক্ষণ করবে। অন্যদিকে, VARCHAR ডেটা টাইপে ডেটার লেংথ পরিবর্তনশীল যেমন: VARCHAR(10) দিলে আপনি "abc" লিখলে ঠিক "abc"-ই সংরক্ষণ হবে, কোনো স্পেস প্যাড করা হবে না।

## #4 Explain the purpose of the WHERE clause in a SELECT statement

#### SQL WHERE Clause:

SQL এর WHERE clause হচ্ছে SQL (Structured Query Language)-এর একটি মৌলিক অংশ, যেটা ব্যবহার করা হয় ডাটাবেস টেবিল থেকে নির্দিষ্ট শর্ত বা একাধিক শর্তের ভিত্তিতে specific row গুলো filter এবং retrieve করার জন্য। এটি আপনাকে শুধুমাত্র সেই ডেটাগুলো extract করতে সাহায্য করে যেগুলো আপনার defined criteria অনুযায়ী মিলে যায়। এর মাধ্যমে আপনি আপনার SQL query-গুলোর উপর আরও বেশি control পান এবং ডেটার নির্দিষ্ট subset নিয়ে কাজ করতে পারেন।

#### SQL WHERE Clause ব্যবহার:

আপনি SQL WHERE clause ব্যবহার করবেন তখন, যখন কোনো query-র ফলাফলকে নির্দিষ্ট কিছু condition অনুযায়ী সীমাবদ্ধ করতে চান। যেমন:

-   Data Filtering : একটি টেবিল থেকে শুধু সেই row গুলো extract করতে যখন প্রয়োজন যেগুলো নির্দিষ্ট criteria পূরণ করে।
    উদাহরণ: এমন সব employee বের করা যাদের job title নির্দিষ্ট।

-   Data Retrieval : নির্দিষ্ট date range, numerical comparison বা string matching pattern অনুযায়ী record বের করার জন্য। যেমন: যেসব অর্ডার ২০২৪ সালের জানুয়ারি থেকে মার্চের মধ্যে হয়েছে।

-   Data Modification : যখন আপনি কিছু row আপডেট বা ডিলিট করতে চান নির্দিষ্ট condition অনুযায়ী। উদাহরণ: যেসব product-এর price নির্দিষ্ট সীমার বেশি, তাদের status আপডেট করা।

-   Data Joins: যখন আপনি একাধিক টেবিল JOIN করছেন এবং combined result থেকে নির্দিষ্ট ডেটা filter করতে চান।

#### SQL WHERE Clause এর সিনট্যাক্স:

SQL WHERE clause এর basic syntax হলো

```sql
    SELECT column1, column2,
    FROM table_name
    WHERE condition;
```

SELECT এ যেসব column থেকে ডেটা আনতে চান, সেগুলো এখানে উল্লেখ করার জন্য। FROM এর হলো কোন table থেকে ডেটা আনবেন, তা এখানে ডিফাইন করার জন্য । WHERE এ এমন একটি condition লিখবেন, যেটা ঠিক করে দিবে কোন row গুলো রেজাল্টে থাকবে।

WHERE clause-এর ভিতরের condition বিভিন্ন operator এবং value দিয়ে গঠিত হতে পারে। যেমন:

-   তুলনামূলক অপারেটর (Comparison Operators): = (সমান), <> (সমান নয়), < (কম), > (বেশি), <= (কম বা সমান), >= (বেশি বা সমান)
-   যুক্তির অপারেটর (Logical Operators): AND (উভয় শর্ত সত্য হতে হবে), OR (যেকোনো একটি শর্ত সত্য হলেই চলবে), NOT (শর্ত সত্য না হলে)
-   Wildcards এবং Matching : LIKE (pattern অনুযায়ী মিল খোঁজে, যেমন % বা \_ ব্যবহার করে), IN (একাধিক মানের মধ্যে যদি কোনোটি মিলে), BETWEEN (দুইটি মানের মধ্যে থাকলে)
-   NULL Value Handling : IS NULL (কোনো মান নেই এমন চেক করতে), IS NOT NULL (যেখানে মান আছে, তা চেক করতে)

Example:

```sql
    SELECT name, age
    FROM student
    WHERE age > 18 AND department = 'engineering';

```

## #5 Explain the GROUP BY clause and its role in aggregation operations.

#### GROUP BY Clause in SQL:

GROUP BY clause SQL-এর একটি গুরুত্বপূর্ণ অংশ যা aggregation operations এর সাথে ব্যবহার হয় । যেমন COUNT(), SUM(), AVG(), MAX(), MIN() ইত্যাদি। এটি একটি টেবিলের Raw গুলোকে এক বা একাধিক column অনুযায়ী গ্রুপ (group) করে । তারপর প্রতিটি গ্রুপের উপর aggregate function প্রয়োগ করে summary data তৈরি করে । এটি বড় ডেটাসেট থেকে তথ্য বের করতে অপরিহার্য একটি টুল।

-   GROUP BY এর সাথে ব্যবহৃত Aggregate Functions:
-   COUNT() – কতগুলো row আছে
-   SUM() – যোগফল
-   AVG() – গড়
-   MAX() – সর্বোচ্চ মান
-   MIN() – সর্বনিম্ন মান

উদাহরণ:

আমাদের একটা students টেবিল আছে

```sql
 region         | number_of_students    | country   |
 -------------- | --------------------- | --------- |
 Asia           | 100                   | India     |
 Europe         | 150                   | Germany   |
 Middle East    | 200                   | Qatar     |
 Asia           | 250                   | Nepal     |
 Europe         | 300                   | Belgium   |

```

এখন যদি আমরা জানতে চাই প্রতিটি region-এর মোট কতজন স্টুডেন্ট আছে (total student):

```sql
SELECT region, SUM(number_of_students) AS total_student
FROM students
GROUP BY region;
```

Output:

```sql
| region        | total_student |
| ------------  | ------------  |
| Asia          | 350           |
| Middle East   | 200           |
| Europe        | 450           |

```
