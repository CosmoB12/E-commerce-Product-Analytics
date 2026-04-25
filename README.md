# 📊 Product Analytics Report: User Behavior, Conversion & Engagement

---

## 🧠 Overview

This project explores user behavior across the full product lifecycle—from initial interaction to repeat purchase—to uncover friction points, understand engagement patterns, and identify opportunities to improve conversion and retention.

The analysis is based on event-level data (sessions, interactions, purchases, and reviews) and is designed to support decision-making across **Product, Marketing, and Growth teams**.

---

## ❓ Key Business Questions

- How effectively do users move through the purchase funnel?
- Where do users drop off before completing a purchase?
- How engaged are users before converting?
- How long does it take users to make their first and second purchases?
- Which users are most at risk of churn?
- What differentiates active users from churned users?
- How does user feedback reflect product experience?

---

## 📸 Dashboard

![Dashboard](./assets/dashboard.png)

> *Power BI dashboard showing funnel performance, user behaviour, and retention trends*

---

## 📈 Key Findings & Insights

---

### 🚨 1. Early Funnel Drop-Off is the Biggest Issue

- ~73% drop between **Page View → Add to Cart**
- Largest loss point in the funnel

📊 *Funnel Visualization*  
![Funnel](assets/funnel.png)

📂 Query: `analyses/02_where_do_users_drop_off_before_purchase.sql`

**Insight:**  
Users struggle at the **decision stage**, not checkout—indicating unclear value proposition or insufficient product confidence early on.

---

### 🟢 2. Strong Conversion After Intent

- Cart abandonment rate: ~17%
- Users who add to cart are highly likely to purchase

📂 Query: `analyses/02_where_do_users_drop_off_before_purchase.sql`

**Insight:**  
The checkout experience is efficient. Late-stage friction is minimal.

---

### 🔵 3. High Engagement, But Delayed Conversion

- Users perform multiple actions per session
- Only ~34% convert in a single session

📊 *Engagement per User*  
![Engagement](assets/engagement.png)

📊 *Sessions Before Purchase*  
![Sessions Before Purchase](assets/sessions_to_purchase.png)

📂 Query: `analyses/05_how_many_sessions_do_users_need_before_first_purchase.sql`

**Insight:**  
Users are engaged but take time to evaluate before committing—suggesting hesitation and decision friction.

---

### 🔁 4. Multi-Session Decision-Making Behavior

- ~66% of users require multiple sessions to convert  
- Many require 4+ sessions  

📂 Query: `analyses/05_how_many_sessions_do_users_need_before_first_purchase.sql`

**Insight:**  
Purchases are not impulsive. Users likely compare options or need repeated exposure before converting.

---

### 📈 5. High Engagement Drives Conversion

- Users perform multiple interactions before purchase  
- Strong correlation between engagement and likelihood to convert  

**Insight:**  
Engagement is a leading indicator of conversion success.

---

### 🔴 6. Strong Repeat Purchase Behavior (But Infrequent)

- Majority of users return for repeat purchases  
- Median time to second purchase: ~45 days  

📂 Query: `analyses/08_how_long_before_users_make_a_second_purchase.sql`

**Insight:**  
Users are satisfied but return infrequently—suggesting need-based usage rather than habitual engagement.

---

### 🟠 7. Churn is Product-Driven, Not Channel-Driven

- Churn distribution is consistent across:
  - Acquisition channels  
  - Device types  

📊 *Churn by Source*  
![Churn by Source](assets/churn_by_source.png)

📂 Query: `analyses/09_which_channels_have_the_highest_churn.sql`

**Insight:**  
Retention challenges stem from the product experience, not marketing channels.

---

### ⚫ 8. Positive Customer Feedback

- Majority of reviews are rated 4–5  

📂 Query: `analyses/13_what_do_user_reviews_reveal_about_the_product.sql`

**Insight:**  
Product quality is not the primary issue affecting conversion or churn.

---

### ⚠️ 9. Churn Reflects Inactivity, Not Immediate Dissatisfaction

- Defined as 90+ days of inactivity  
- Does not necessarily indicate negative experience  

**Insight:**  
Retention strategies should focus on **re-engagement**, not just product fixes.

---

## 📊 Key Metrics

| Metric                | Description                                       |
|---------------------|---------------------------------------------------|
| Purchase Rate        | % of users who completed a purchase               |
| Cart Abandonment     | % of users who added to cart but did not purchase |
| Avg Sessions/User    | Engagement level                                  |
| Sessions to Purchase | Number of sessions before first purchase          |
| Churn Rate           | Users inactive for 90+ days                       |

---

## 🧪 Methodology

### Data Sources

- `events_fact` – user events (page view, add to cart, checkout, purchase)
- `sessions_dim` – session-level data
- `date_dim` – time-based analysis

---

## 🧾 SQL Analysis

### 🔹 Funnel Conversion Analysis

```sql
SELECT
    ef.event_type,
    COUNT(*) AS total_events,
    COUNT(DISTINCT sd.customer_id) AS total_users,
    COUNT(*) * 1.0 / COUNT(DISTINCT sd.customer_id) AS avg_events_per_user
FROM events_fact ef
JOIN sessions_dim sd
    ON ef.session_id = sd.session_id
WHERE event_type IN ('add_to_cart','checkout','purchase')
GROUP BY ef.event_type;
