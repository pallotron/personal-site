---
title: "Expenses Analyzer"
date: "2025-11-02T08:04:26+01:00"
draft: false
---

A Textual TUI application for analyzing your personal expenses.

## Story Time

This project was born out of a combination of necessity and curiosity. After an injury left me with limited mobility and a lot of time on my hands, I found myself wanting to get a better handle on my expenses. I have multiple bank accounts, and I've always been frustrated by the subpar reporting and data export features they offer.

Even modern fintech apps like Revolut, which I love for many reasons, have their own quirks and limitations. For instance, their expense and cash flow reporting features are great, the integration with PTSB is ok and allows me to import the transactions into Revolut, but it's missing direct debits, and there's no sign of a fix in sight.

With my typing ability temporarily reduced, I needed a project that I could work on in short bursts, something that didn't require constant, strenuous typing. This seemed like the perfect opportunity to give "vibe coding" a try.

I decided to build a tool that would finally let me consolidate and analyze my expenses data in a way that made sense to me.

At the same time, I'd been wanting to learn [Textual](https://textual.textualize.io/), a TUI (Text User Interface) framework for Python. The idea of building a powerful, interactive, and terminal-based application was really appealing. So, I decided to combine these goals and create Expense Analyzer. It's a personal tool, born out of a specific set of circumstances, but I hope it can be useful to others who share my frustrations with personal finance management.

## Features

- **Import Transactions**: Import your financial transactions from CSV files.
- **Automatic Categorization**: Automatically categorizes your expenses using Google's Generative AI.
- **Expense Summary**: View a summary of your expenses, broken down by year and month.
- **Category Breakdown**: See a detailed breakdown of your spending by category.
- **Transaction Viewer**: Browse and review individual transactions.
- **Data Deletion**: Remove transactions you don't want to track.

## References

- [Textual](https://textual.textualize.io/)
- [Google Gemini](https://deepmind.google/technologies/gemini/)
- [Pandas](https://pandas.pydata.org/)
- [Parquet](https://parquet.apache.org/)
- [Blog post about the development process](/posts/2025/11/02/expenses_analyzer/)
- [GitHub Repository](https://github.com/pallotron/expenses_analyzer)
