> - **[OpenActive: RPDE specification](hhttps://github.com/openactive/realtime-paged-data-exchange/blob/master/README.md)** - the spec.
> - [OpenActive: Activation Issue Tracker](https://github.com/openactive/activation) - help implementing the spec. 
> - [OpenActive: The Steps](https://www.openactive.io/technology.html#the-steps) - what to do after you've implemented the spec. 

# OpenActive: Real-Time Paged Data Exchange Specification [![Build Status](https://travis-ci.org/openactive/realtime-paged-data-exchange.svg?branch=master)](https://travis-ci.org/openactive/realtime-paged-data-exchange)

This specification tackles the generic use-case of unidirectional real-time data synchronisation between two systems, where the receiving system requires only summary data from the origin system.

[//]: # (Below the SNIP is included in Openactive.io)
[//]: # (_SNIP_)

####  Getting Started

To get started, build a single API endpoint that conforms to the specification, and check it with the validator:

- **[Current Specification](https://www.openactive.io/realtime-paged-data-exchange/)**
- [Validator](https://www.openactive.io/endpoint-validator/)

If you have any issues implementing the standard or have any questions relating to it, please do post an issue to the [Activation Issue Tracker](https://github.com/openactive/activation).

####  Implementation checklist

Before posting the example implementation to the [Activation Issue Tracker](https://github.com/openactive/activation/issues), check the following common issues have been included in your thinking:

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
- Is the Next URL present on the last page?
- Are HTML or Markdown encoded data fields included in plain as well as raw form as separate fields?
- Do embedded related entities have IDs?
- If an embedded related entity is updated, does the main item's timestamp reflect this?
- Are all URLs absolute? Is the next URL absolute?
- Are images included where available, with URLs to each thumbnail size available as well as the original image?
- For image URLs, is an empty string is returned instead of a placeholder image when there is no image available?
- Are all responses returned with header `Content-Type: application/json`?
- Are the next URL parameters urlencoded?

### Specification Revision History

No breaking changes are made within a major version (e.g. 1.x.x), and no additive changes made within a minor version (e.g. 1.1.x).

Version | Date Published | Change Log | Change Summary
---|---|---|---|---
 [0.1.0](https://www.openactive.io/realtime-paged-data-exchange/0.1.0/) | 1 Nov 2015  | [Commits](https://github.com/openactive/realtime-paged-data-exchange/commits/master/0.1.0/index.html) [Issues](https://github.com/openactive/realtime-paged-data-exchange/milestones/0.1.0) | Draft specification circulated for the purposes of gathering feedback.
 [0.2.0](https://www.openactive.io/realtime-paged-data-exchange/0.2.0/) | 28 Jan 2016 | [Commits](https://github.com/openactive/realtime-paged-data-exchange/commits/master/0.2.0/index.html) [Issues](https://github.com/openactive/realtime-paged-data-exchange/milestones/0.2.0) | Improved to increase clarity, and additional real-time transport options.
 [0.2.2](https://www.openactive.io/realtime-paged-data-exchange/0.2.2/) | 26 Feb 2016 | [Commits](https://github.com/openactive/realtime-paged-data-exchange/commits/master/0.2.2/index.html) [Issues](https://github.com/openactive/realtime-paged-data-exchange/milestones/0.2.2) | Additional implementation guidance added.
 [0.2.3](https://www.openactive.io/realtime-paged-data-exchange/0.2.3/) | 1 May 2016 | [Commits](https://github.com/openactive/realtime-paged-data-exchange/commits/master/0.2.3/index.html) [Issues](https://github.com/openactive/realtime-paged-data-exchange/milestones/0.2.3) | Migrated from Google Docs to Respec while clarifying minor elements of the specification.
 [Editor's Draft](https://www.openactive.io/realtime-paged-data-exchange/) | May 2016 | [Commits](https://github.com/openactive/realtime-paged-data-exchange/commits/master/EditorsDraft/index.html)  [Issues](https://github.com/openactive/realtime-paged-data-exchange/milestones/Editor's%20Draft) [Validator](https://www.openactive.io/endpoint-validator/) | Addresses a wide range of feedback from various implementing pioneers reduce ambiguity. Also implements a breaking change to the "next" links in order align more closely to JSON-LD.
