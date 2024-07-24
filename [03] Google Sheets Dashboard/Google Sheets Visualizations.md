- Count of Unique Brands
```
=COUNTA(UNIQUE(Data!J2:J97))
```
- Lowest Price
```
=MIN(Data!C:C)
```
- Highest Price
```
=MAX(Data!C:C)
```
- Average Discount %
```
=AVERAGE(Data!D:D)
```
- Count of Products
```
=COUNTA(Data!B2:B97)
```
- Average Rating
```
=AVERAGE(Data!E:E)
```
- Top 5 Most Reviewed Products
```
=query(Data!A1:97, "Select B,F Order by F Desc Limit 5")
```
