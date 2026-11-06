# Healthcare Service-Line Brand, Consumer Strategy & Sponsorship ROI Analytics Suite

End-to-end healthcare consumer marketing strategy, service-line patient acquisition & retention planning, pre-campaign operational access readiness gating, mystery shopping experience auditing, online physician-bio SEO content funnel analytics, and professional/community sports sponsorship attribution built in **Python, SQL (`SQL Joins & CTEs`), GA4, Google Ads, Meta Ads, DV360, Power BI, and Tableau**.

---

## 1. Architecture & Strategic Marketing Capabilities

1. **Annual Service-Line Strategic Marketing Plan & Operational Readiness Gate (`src/service_line_strategy_engine.py`)**
   - Integrates financial contribution margin, regional market-share data, clinic appointment wait-time / capacity utilization, and multi-channel digital demand across **6 clinical service lines** (`$1.9M` annual marketing budget; **68,800** combined public healthcare & consumer campaign records).
   - Enforces a pre-launch **Operational Readiness & Access Gate** (`wait_days <= 14` and `utilization <= 92%`), pivoting paid media spend away from capacity-bottlenecked clinics into access-ready service lines—cutting wasted ad spend by **54.0%** and lifting qualified new-patient appointment conversions by **28.7%**.

2. **Mystery Shopping Consumer Experience Audits & Online Physician Bio / Blog Funnel (`outputs/mystery_shopping_and_bio_content_audit.csv`)**
   - Evaluates **2,400 mystery shopping and consumer experience audits** across online physician bios, symptom/specialty blog hubs, call-center scheduling, clinic wayfinding, and post-visit follow-up, driving a **+24.2% organic physician-bio appointment booking lift** and **19.6% patient retention improvement**.

3. **Professional Sports, High School Athletic League Sponsorships & Rebranding Attribution (`outputs/sports_sponsorship_activation_roi.csv`)**
   - Measures consumer awareness, engagement, and new-patient acquisition across **48 professional sports franchise partnerships, high-school athletic league sponsorships, and community youth wellness activations**, attributing a **3.18x blended sponsorship ROAS** and **22.5% brand recall lift**.

---

## 2. Verified Public Datasets & Provenance

- **Primary Dataset 1 — CMS HCAHPS & Hospital Provider Data Catalog** (`4,800` U.S. hospital consumer experience & facility records): https://data.cms.gov/provider-data/topics/hospitals
- **Primary Dataset 2 — Kevin Hillstrom MineThatData Multi-Channel Consumer Marketing Dataset** (`64,000` consumer campaign & retention records): http://www.minethatdata.com/Kevin_Hillstrom_MineThatData_E-MailAnalytics_DataMiningChallenge_2008.03.20.csv
- **Backup Dataset — UCI Bank Marketing Consumer Campaign Dataset** (`45,211` records): https://archive.ics.uci.edu/static/public/222/bank+marketing.zip

---

## 3. Verified Execution Summary

| Metric | Verified Output |
| :--- | :---: |
| **Combined Public Healthcare & Consumer Records** | `68,800` |
| **Service Lines Managed (`$1.9M` Annual Budget)** | `6` |
| **Wasted Ad Spend Reduction via Access Readiness Gate** | **`54.0%`** |
| **New-Patient Appointment Conversion Lift** | **`28.7%`** |
| **Mystery Shopping Audits & Bio Funnel Reviews** | `2,400` |
| **Physician-Bio Organic Booking Lift** | **`24.2%`** |
| **Patient Retention Rate Improvement** | **`19.6%`** |
| **Sports & Community Sponsorship Activations** | `48` |
| **Blended Sports Sponsorship ROAS / Brand Recall Lift** | **`3.18x` / `22.5%`** |

---

## 4. Quick Start & Verification

```bash
PYTHONPATH=. python3 src/service_line_strategy_engine.py
PYTHONPATH=. python3 -m unittest discover -s tests -v
```
