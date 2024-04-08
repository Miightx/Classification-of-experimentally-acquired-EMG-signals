## Classification of experimentally acquired EMG signals
The experiment carried out with the Noraxon DTS system and electrodes provide a way to identify the muscles used during different tasks done in sequences. Using a toolbox, we are going to develop process systems to recover the signals and analyse the rate of correlation between the actual movements executed and the signals detected. By understanding the relationship between muscle activation and specific movements allow us to understand not only human behavior but also to improve the robotic system. Such improvement has the potential to improve the daily life of numerous people.

In order to execute the motion, six electrodes were placed on :
- Biceps
- Triceps
- Wrist flexor
- Wrist extensor
  
These recording placement supply the necessary informations to evaluate :

- Elbow (flexion/extension)
- Wrist (flexion/extension and pronation/supination)
- Hand (closing/opening)
- Thumb-index pinch (closing/opening)
We effectuate a LDA classification to train and test the datas. In order to classify, we used the RMS and autoregressive coefficients formulas.

![signal processing ](https://github.com/Miightx/Classification-of-experimentally-acquired-EMG-signals/assets/117952621/264b751f-4d85-47b0-a4c8-72489b0ad15b)

In the repository, you will find the report, the results and the MATLAB code to perform the classification.
