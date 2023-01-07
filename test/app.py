import numpy as np
import matplotlib.pyplot as plt

x = np.arange(0, np.pi*2, 0.1)
y = np.sin(x)

plt.figure()
plt.plot(x, y)
plt.xlabel('x')
plt.ylabel('sin(x)')
plt.grid()
plt.savefig('fig.png')
plt.show()
