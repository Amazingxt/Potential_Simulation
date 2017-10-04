## Potential Simulation For Blade Ion trap

* 利用.geo文件（需要用Gmsh进行编辑）生成.msh文件

> Blade_old中刀片的结构是马里兰大学克里斯梦露组的设计，其中相邻两个刀片的夹角是60度
>
> Blade_new中的刀片是USTC黄运锋组（我们组）的设计，其中相邻两个刀片的夹角是15度

* Trap_Simulation_Document中是示例文档
* data和data_new分别是由Blade_Sim_movie生成的两种结构刀片静态电势的数据
* needle文件是needle阱的结构文件
* balde_picture_show.py和balde_movie_show.py文件分别生成静电势图片和动态电势，需要在cmd下运行