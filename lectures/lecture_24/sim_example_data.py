'''
Generate toy example for the Bayes Classifier walkthrough.

Data to emulate "civil war" outcome. Simple linear boundary.
'''
import pandas as pd
import numpy as np
import scipy.stats as st
np.random.seed(1234)
N = 20
x1 = np.random.binomial(1,.5,N)
x2 = np.random.binomial(1,.5,N)
z = -.5 - x1 + x2 
pr = st.norm.cdf(z)
y = np.random.binomial(1,pr)
D = pd.DataFrame(np.vstack([y,x1,x2]).T,columns=['civil_war','developed','authoritarian'])
D.to_csv("~/Desktop/civil_war.csv",index=False)