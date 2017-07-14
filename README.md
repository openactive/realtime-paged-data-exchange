> - **[OpenActive: RPDE specification](hhttps://github.com/openactive/realtime-paged-data-exchange/blob/master/README.md)** - the spec.
> - [OpenActive: Activation Issue Tracker](https://github.com/openactive/activation/blob/master/README.md) - help implementing the spec. 
> - [OpenActive: The Steps](https://www.openactive.io/technology.html#the-steps) - what to do after you've implemented the spec. 

# OpenActive: Real-Time Paged Exchange Specification [![Build Status](https://travis-ci.org/openactive/realtime-paged-data-exchange.svg?branch=master)](https://travis-ci.org/openactive/realtime-paged-data-exchange)

This specification tackles the generic use-case of unidirectional real-time data synchronisation between two systems, where the receiving system requires only summary data from the origin system.

[//]: # (Below the SNIP is included in Openactive.io)
[//]: # (_SNIP_)

###  Getting Started

To get started post an example on the [Activation Issue Tracker](https://github.com/openactive/activation/blob/master/README.md), build a new API endpoint that conforms to the specification, and check it with the validator:

- **[Current Specification (Editor's Draft)](https://www.openactive.io/realtime-paged-data-exchange/)** - Section 3-4 explains the concept, Section 4.6 is an example.
- [Validator](https://www.openactive.io/endpoint-validator/)

###  Implementation checklist

Before posting the example implementation to the [Activation Issue Tracker](https://github.com/openactive/activation/blob/master/README.md), check the following common issues have been included in your thinking:

- Date formats, are you using ISO8601 for all user-facing dates, and integers for timestamps
  - Are your user-facing dates ISO8601 format, expressed as local time with a correct offset from UTC (e.g "2016-07-13T20:00:00-05:00"), or as UTC (e.g. "2014-08-12T18:50:00Z")
  - Are you using integer "modified" timestamps? (recommended but not required)
- Are records deleted from your system marked with a deleted flag and included in the "Deleted" state
- Does your feed include all historical data from the beginning of time and not just data in the future or from today's date? 
- Does the endpoint without any parameters return the first page (from the beginning of time)?
- Have you included as many data fields as possible
- Does your implementation match your internal state as closely as possible (i.e. you are not generating sessions that don't actually yet exist as records in your system from a recurrance rule, but are instead providing the recurrance rule data directly).
- Does each page contain a "license" key (see [this issue](https://github.com/openactive/activation/issues/19) for details, note that this is not yet updated in the spec)?
- Are Session URLs included in the data block for each session, so a user can find out details from source?
- Is the Next URL present on the last page? The Next URL on the last page (no items) should default to the ID and timestamp of the current request
- Are HTML or Markdown encoded data fields included in plain as well as raw form as separate fields?
- Do embedded related entities have IDs?
- If an embedded related entity is updated, does the main item's timestamp reflect this?
- Are all URLs absolute? Is the next URL absolute?
- Are images included where available, with URLs to each thumbnail size available as well as the original image?
- For image URLs, is an empty string is returned instead of a placeholder image when there is no image available?
- Are all responses returned with header `Content-Type: application/json`?
- Are the next URL parameters urlencoded?
- Are you using the correct database query to return data for each page, with the `>` and `=` operators correctly placed? See [this sample code](https://github.com/openactive/rpde-sample-azure/blob/master/RpdeSample/run.csx) for a SQL equivalent of the pseudocode in the specification. The `where` clause should look as follows for the case where afterId and afterTimestamp are both used: `WHERE (MODIFIEDDATE = @afterTimestamp AND ID > @afterId) OR (MODIFIEDDATE > @afterTimestamp)`

### Specification Revision History

No breaking changes are made within a major version (e.g. 1.x.x), and no additive changes are made within a minor version (e.g. 1.1.x).

---|---|---|---|---
Version | Date Published | Change Log | Change Summary
---|---|---|---|---
 [0.1.0](https://www.openactive.io/realtime-paged-data-exchange/0.1.0/) | 12 Nov 2015  | [Commits](https://github.com/openactive/realtime-paged-data-exchange/commits/master/0.1.0/index.html) [Issues](https://github.com/openactive/realtime-paged-data-exchange/milestones/0.1.0) | Draft specification circulated for the purposes of gathering feedback.
 [0.2.0](https://www.openactive.io/realtime-paged-data-exchange/0.2.0/) | 6 Feb 2016 | [Commits](https://github.com/openactive/realtime-paged-data-exchange/commits/master/0.2.0/index.html) [Issues](https://github.com/openactive/realtime-paged-data-exchange/milestones/0.2.0) | Improved to increase clarity, and additional real-time transport options.
 [0.2.1](https://www.openactive.io/realtime-paged-data-exchange/0.2.1/) | 31 Mar 2016 | [Commits](https://github.com/openactive/realtime-paged-data-exchange/commits/master/0.2.1/index.html) [Issues](https://github.com/openactive/realtime-paged-data-exchange/milestones/0.2.1) | Minor change to case
 [0.2.2](https://www.openactive.io/realtime-paged-data-exchange/0.2.2/) | 26 Apr 2016 | [Commits](https://github.com/openactive/realtime-paged-data-exchange/commits/master/0.2.2/index.html) [Issues](https://github.com/openactive/realtime-paged-data-exchange/milestones/0.2.2) | Additional implementation guidance added.
 [0.2.3](https://www.openactive.io/realtime-paged-data-exchange/0.2.3/) | 1 May 2016 | [Commits](https://github.com/openactive/realtime-paged-data-exchange/commits/master/0.2.3/index.html) [Issues](https://github.com/openactive/realtime-paged-data-exchange/milestones/0.2.3) | Migrated from Google Docs to Respec while clarifying minor elements of the specification.
 [0.2.4](https://www.openactive.io/realtime-paged-data-exchange/0.2.4/) | 26 May 2016 | [Commits](https://github.com/openactive/realtime-paged-data-exchange/commits/master/0.2.4/index.html) [Issues](https://github.com/openactive/realtime-paged-data-exchange/milestones/0.2.4) | Addresses a wide range of feedback from various implementing pioneers reduce ambiguity.
 [0.3.0](https://www.openactive.io/realtime-paged-data-exchange/0.3.0/) | 21 Jun 2017 | [Commits](https://github.com/openactive/realtime-paged-data-exchange/commits/master/0.3.0/index.html) [Issues](https://github.com/openactive/realtime-paged-data-exchange/milestones/0.3.0) | Recommendation linking to the OpenActive Modelling Opportunity Data Specification.
 [Editor's Draft](https://www.openactive.io/realtime-paged-data-exchange/) | May 2016 | [Commits](https://github.com/openactive/realtime-paged-data-exchange/commits/master/EditorsDraft/index.html)  [Issues](https://github.com/openactive/realtime-paged-data-exchange/milestones/Editor's%20Draft) [Validator](https://www.openactive.io/endpoint-validator/) | Increase in clarity and specificity based on many implementations over the past year.
 ---|---|---|---|---
