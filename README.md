# Airline-Passenger-Experience-Analysis-Python-MySQL-PowerBI

Problem Statement: 

Analyze how flight delays, travel class, customer loyalty, and onboard service quality influence passenger satisfaction, and identify the key areas airlines should improve to enhance customer experience.


Objective: 

To have better understanding of factors impacting passenger satisfactions and highlight area of improvements. This analysis would help airline teams monitor experience quality and identify service or operational pain points affecting satisfaction.


Dataset:

Dataset is fetched from Kaggle and raw uncleaned dataset is mentioned in project repository as Raw_Dataset.csv. Columns inside dataset are segregated for my better understanding. Segregation is done as mentioned below

1. Passenger profile: Gender, Age, Customer Type 

2. Travel details: Type of Travel, Class, Flight Distance 

3. Operational metrics: Departure Delay in Minutes, Arrival Delay in Minutes 

4. Service quality metrics: Inflight wifi service, Ease of Online booking, Gate location, Food and drink, Online boarding, Seat comfort, Inflight entertainment, On-board service, Leg room service, Baggage handling, Checkin service, Inflight service, Cleanliness 

5. Outcome: satisfaction


Tools:

Python (Pandas, Matplotlib, Seaborn) | MySQL | Power BI


Project Workflow:

Data Cleaning, Feature Engineering and Outlier detection analysis using Python Libraries like Pandas, Matplotlib and Seaborn. Removed null values from each column. In existing data we done feature engineering on columns to segregate data in categories. In Delay Flag, we created categories based on arrival time delay. This will help us to track impact of delayed flights on customer satisfaction level and service ratings. In Age Group, we segreggated categories to see satisfaction level of each age group. In Distance Bucket we created categories based on distance to underastand which service needs to be improved in each distance segment. Basic level analysis done to decide which segments to track further in SQL for further analysis. We analyzed below mentioned points in python with the help of pandas library:

1. Travel class is a major driver of satisfaction. 
2. Arrival and departure delay is almost same for every class, type of travel, distance bucket, customer type segments. Approximately ranging between 15-20 mins.
3. In type of travel, Business travel passengers are more satisfied than personal travel passengers.
4. Delayed passengers are more likely to be dissatisfied.
5. Short-haul experience is weaker than long-haul experience.
6. Disloyal customers show much higher dissatisfaction.

Cleaned dataset imported to MySQL using SQLAlchemy and then analyzied data patterns in MySQL. After SQL analysis we found below mentioned points:

1. Dissatisfaction is the dominant outcome overall, and it persists even on on-time flights.
2. Business class performs well, but Eco and Eco Plus are dragging overall passenger experience down.
3. Personal travel is the weakest segment by far, especially when delays occur.
4. Online boarding, inflight wifi, and booking experience are the clearest service levers for improvement.

Dashboard Creation is done based on above analysis in Power BI. We created new measures for showcasing overall numbers in KPI cards. To average service ratings, we used data modeling. 


Insights:

1. The airline has a broad satisfaction problem, not just a niche one. Overall satisfaction is 43.45%, while dissatisfaction is 56.55%. Average service rating is only 3.2/5, which means the experience is not catastrophically bad, but it is not strong enough to create satisfaction consistently. That gap matters because dissatisfaction is not coming from one tiny pocket — it is the dominant outcome overall.

2. Delays always lead to not statisfied passengers, but delays are not the whole story. Delayed flights are 54.16% of records, and delayed passengers have lower satisfaction than on-time passengers, but even on-time flights still have more dissatisfied than satisfied passengers. That is the big tell: operational punctuality matters, but fixing delays alone will not solve the experience problem. There is a parallel service-quality problem sitting underneath the delay problem.

3. Business class is carrying the brand experience. Business class is the only class with a clearly strong satisfaction outcome at 69.45% satisfaction, while Eco and Eco Plus are heavily led by dissatisfaction. Business class also has the highest average service rating at 3.43, while Eco and Eco Plus sit around 3.06–3.07. This suggests the airline already knows how to create a better experience — but that experience is concentrated in Business class and not translating to lower classes.

4. Eco Plus is the most fragile class when delays happen. Eco Plus shows the largest satisfaction drop when flights go from on-time to delayed. 

5. Personal travel is the highest-risk journey type. Business travel has 58.37% satisfaction, but personal travel has only 10.13% satisfaction and 89.87% dissatisfaction. That is massive. It says passenger experience is breaking far more badly for leisure/personal customers than for business travelers. On top of that, among delayed passengers, the worst satisfaction is observed in personal travel across all classes.

6. Loyalty helps, but not enough. Loyal customers do better than disloyal customers on satisfaction, but even loyal customers still lean slightly toward dissatisfaction. Also, both loyal and disloyal customers show similar average delays, which suggests loyalty is not protected operationally. Loyal customers are not getting fewer delays, they may just be more tolerant or receiving a somewhat better service layer. That’s important because it means loyalty is not a cure; the core experience still needs fixing.

7. The biggest pain points are digital and pre-boarding experience. The weakest service attributes overall are inflight wifi, ease of online booking, and gate location. And the biggest rating gap between satisfied vs dissatisfied passengers is online boarding, followed by inflight entertainment. That’s huge. It means the strongest levers are not just make flights on time, but also fix the experience moments that most separate happy from unhappy customers. Online boarding is especially a high-impact lever because it shows the largest perception gap.

8. Volume and poor experience gives action priority. The biggest volume sits in Business and Eco classes, Short Haul, and Business Travel. But the most damaging pockets are not just high-volume ones. They are high-volume segments with poor satisfaction. Eco class, Eco Plus class, Personal travel passengers suffering most.


Recommendations:

1. Prioritize segment Eco + Personal Travel + Loyal Customer:

This segment should be addressed first because it combines high passenger volume and consistently high dissatisfaction, even when flights are on time. The problem appears to be driven less by delays alone and more by a broader experience gap across service touchpoints. The airline should improve value perception and customer journey quality for this group, especially in areas such as online boarding, booking experience, and inflight connectivity.

2. Improve Eco Plus / Eco Business Travel experience:

Eco Plus and Eco passengers traveling for business, across both loyalty groups, represent the clearest combined-risk segments. These groups show low service ratings, high dissatisfaction, and relatively high delays, indicating that both service delivery and operational disruption are hurting experience. The airline should improve delay recovery, disruption communication, and service consistency for these travelers.

3. Protect Business + Business Travel + Loyal Customers

This segment has the highest passenger volume and therefore deserves close monitoring even if it is not the worst-performing group. Since service ratings are relatively strong, the focus should be on maintaining service consistency and protecting the experience of a high-value customer base. This segment should be managed as a retention and brand-protection segment.






