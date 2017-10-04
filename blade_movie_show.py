import pickle

filename = 'data_new'

f = open(filename, 'rb')
data = pickle.load(f)
f.close()



from mpl_toolkits.mplot3d import axes3d
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation

halfrange = 10

def generate(X, Y, phi):
    return 10 * (data[phi] - data[phi][len(data[phi])/2, len(data[phi])/2])

fig = plt.figure()
ax = axes3d.Axes3D(fig)

X = np.arange(-halfrange,halfrange,1)
Y = np.arange(-halfrange,halfrange,1)
X, Y = np.meshgrid(X, Y)
Z = generate(X, Y, 0)
wframe = ax.plot_surface(X, Y, Z, rstride=1, cstride=1, cmap='rainbow')
#wframe = ax.plot_wireframe(X, Y, Z, rstride=2, cstride=2)
#ax.set_zlim(-1,1)

def update(i, ax, fig):
    ax.cla()
    phi = i % 72
    Z = generate(X, Y, phi)
#   wframe = ax.plot_wireframe(X, Y, Z, rstride=2, cstride=2)
    wframe = ax.plot_surface(X, Y, Z, rstride=1, cstride=1, cmap='rainbow')
    ax.set_zlim(-1,1)
    return wframe,

ani = animation.FuncAnimation(fig, update, 
        frames=xrange(100), 
        fargs=(ax, fig), interval=100)
plt.show()












# import numpy as np
# import matplotlib.pyplot as plt
# import matplotlib.animation as animation

# fig = plt.figure()


# def f(x, y):
#     return np.sin(x) + np.cos(y)

# x = np.linspace(0, 2 * np.pi, 120)
# y = np.linspace(0, 2 * np.pi, 100).reshape(-1, 1)

# im = plt.imshow(f(x, y), animated=True)


# def updatefig(*args):
#     global x, y
#     x += np.pi / 15.
#     y += np.pi / 20.
#     im.set_array(f(x, y))
#     return im,

# ani = animation.FuncAnimation(fig, updatefig, interval=50, blit=True)
# plt.show()
# import numpy as np
# import matplotlib.pyplot as plt
# import mpl_toolkits.mplot3d.axes3d as p3
# import matplotlib.animation as animation


# def Gen_RandLine(length, dims=2):
#     """
#     Create a line using a random walk algorithm

#     length is the number of points for the line.
#     dims is the number of dimensions the line has.
#     """
#     lineData = np.empty((dims, length))
#     lineData[:, 0] = np.random.rand(dims)
#     for index in range(1, length):
#         # scaling the random numbers by 0.1 so
#         # movement is small compared to position.
#         # subtraction by 0.5 is to change the range to [-0.5, 0.5]
#         # to allow a line to move backwards.
#         step = ((np.random.rand(dims) - 0.5) * 0.1)
#         lineData[:, index] = lineData[:, index - 1] + step

#     return lineData


# def update_lines(num, dataLines, lines):
#     for line, data in zip(lines, dataLines):
#         # NOTE: there is no .set_data() for 3 dim data...
#         line.set_data(data[0:2, :num])
#         line.set_3d_properties(data[2, :num])
#     return lines

# # Attaching 3D axis to the figure
# fig = plt.figure()
# ax = p3.Axes3D(fig)

# # Fifty lines of random 3-D lines
# data = [Gen_RandLine(25, 3) for index in range(50)]

# # Creating fifty line objects.
# # NOTE: Can't pass empty arrays into 3d version of plot()
# lines = [ax.plot(dat[0, 0:1], dat[1, 0:1], dat[2, 0:1])[0] for dat in data]

# # Setting the axes properties
# ax.set_xlim3d([0.0, 1.0])
# ax.set_xlabel('X')

# ax.set_ylim3d([0.0, 1.0])
# ax.set_ylabel('Y')

# ax.set_zlim3d([0.0, 1.0])
# ax.set_zlabel('Z')

# ax.set_title('3D Test')

# # Creating the Animation object
# line_ani = animation.FuncAnimation (fig, update_lines, 25, fargs=(data, lines),
#                                    interval=50, blit=False)

# plt.show()