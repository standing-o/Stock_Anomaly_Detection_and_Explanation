# Stock Anomaly Detection and Explanation
- Repository for my master thesis
- In this paper, we introduce the anomaly detection using deep learning models and the explanation with MSTs in the US stock market. And we describe the mathematical formulation for the RNN/LSTM.
- Jul. 1, 2022 ~ Jan. 6, 2023

&nbsp;
&nbsp;
&nbsp;

## [A Deep Learning Approach to US Stock Market Analysis and its Explanation Using Correlation Networks](https://drive.google.com/file/d/1dw2jc4f7pvUn6FpbGl5Uo_Ddn9mGUzLV/view?usp=sharing)
미국 주식시장 분석을 위한 딥러닝 접근법과 상관관계 네트워크를 이용한 해석   
> **Abstract** Neural networks are artificial intelligence algorithms that excel at pattern recognition tasks and have been widely used to handle time series data. In particular, the anomaly detection of time series plays an important role in the financial field. Most previous efforts related to time series anomaly detection have been aimed at improving the performance of model. But these days, some studies in the financial field emphasize the need to explain the AI models. In this paper, we detect anomalous behaviors on US stock market using Long short term memory (LSTM) algorithms based on neural networks. And, we propose a method to increase the explanatory power and confidence of deep learning by representing the predictive results on minimum spanning trees (MSTs). We show that this approach gives insight into anomaly pattern, which is compared to the past dynamics in stock market. And we explain it in relation to Covid-19 pandemic.

## Dataset
- Closing prices of DOW-30 (except DOW stock) retrieved using the Yahoo Finance API for the period between 2008-06-02 and 2021-01-29.
- The return is calculated separately for each stock, and the LSTM learning is also performed separately. 
<div align="center">
<img src="https://user-images.githubusercontent.com/57218700/210920954-ef1fdb22-31fd-4078-a683-c58e17870d85.png?raw=True" width="40%">   
<img src="https://user-images.githubusercontent.com/57218700/210920554-40a2e4a9-1fb9-48f5-bd7f-28916d43eee9.png?raw=True" width="40%"> <br>
</div>

## Anomaly Detection Using LSTMs | [Code](https://github.com/standing-o/Stock_Anomaly_Detection_and_Explanation/blob/master/main.ipynb)
- We use the LSTM architecture with 64 nodes following ReLU activation function and a neural network with 1-layer (Dense layer) with a node.
- The thresholds that determine the anomaly points are calculated by 0.99 quantile value of the train mean squared error (MSE). In the test MSE, points larger than thresholds were determined as anomaly points.
- The histogram for the test MSE and the threshold value obtained by the train MSE for CVX, INTC,MRK and XOM are depicted below.
<div align="center">
<img src="https://user-images.githubusercontent.com/57218700/210923896-b4f5d376-c311-4e7c-9d1d-b7be9f0a4b4f.png?raw=True" width="30%">  
<img src="https://user-images.githubusercontent.com/57218700/210923900-c6b54287-8036-4277-aa1d-85505d669f4f.png?raw=True" width="30%"> <br>
<img src="https://user-images.githubusercontent.com/57218700/210923901-23ca18cd-42e9-4e2f-a985-266682f9d657.png?raw=True" width="30%">
<img src="https://user-images.githubusercontent.com/57218700/210924220-7913099f-e23d-4f5d-a958-6a23b57ea52c.png?raw=True" width="30%"> <br>
</div>

- Anomaly points and closing prices for CVX, INTC, MRK and XOM are as follows:
<div align="center">
<img src="https://user-images.githubusercontent.com/57218700/210923408-de0ae600-dcd8-47bc-a264-df84cd9fd457.png?raw=True" width="45%">  
<img src="https://user-images.githubusercontent.com/57218700/210923413-3d84e50d-e34d-4e96-afeb-764c431e11b1.png?raw=True" width="45%"> <br>
<img src="https://user-images.githubusercontent.com/57218700/210923416-982cf65b-244b-4a0c-a2b6-4cbd643ccebc.png?raw=True" width="45%">
<img src="https://user-images.githubusercontent.com/57218700/210924207-786f1b5c-b69a-4484-8803-a902bdb15312.png?raw=True" width="45%"> <br>
</div>

## MST representation | [Code](https://github.com/standing-o/Stock_Anomaly_Detection_and_Explanation/blob/master/max_times_vis.R)
- We generate MSTs using the daily return value of the closing price for the last 272 days. We divide 272 days into four sections and mark the number of anomaly points in each section in color on each node of MSTs. The closer to the orange, the more the number is.

<div align="center">
<img src="https://user-images.githubusercontent.com/57218700/210924747-40f62649-b013-4aee-8822-1f2b8e1019ff.png?raw=True" width="35%">  
<img src="https://user-images.githubusercontent.com/57218700/210924751-4c40f390-5dcf-4f40-8926-3bfec20f3ccc.png?raw=True" width="35%"> <br>
<img src="https://user-images.githubusercontent.com/57218700/210924752-6dbdfe5a-5617-4f47-8cc6-38286b0d6b04.png?raw=True" width="35%">
<img src="https://user-images.githubusercontent.com/57218700/210924753-6b84b87f-d116-4981-8e08-03c76752c7ff.png?raw=True" width="35%"> <br>
</div>

