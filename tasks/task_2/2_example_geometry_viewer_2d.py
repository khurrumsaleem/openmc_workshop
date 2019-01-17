#!/usr/bin/env python3

"""example_isotope_plot.py: plots few 2D views of a simple geometry ."""

__author__      = "Jonathan Shimwell"

import openmc
import matplotlib.pyplot as plt

natural_lead = openmc.Material(1, "natural_lead")
natural_lead.add_element('Pb', 1,'ao')
natural_leads.set_density('g/cm3', 11.34)

# natural_copper = openmc.Material(2, "natural_copper") #hint this is an example material you will need another one called natural_tungsten ,density is 19.3
# natural_copper.add_element('Cu', 1,'ao')
# natural_copper.set_density('g/cm3', 8.96)

# sheild_material = openmc.Material(3, "mixed_tungsten_water")
# sheild_material.add_material(natural_tungsten, 0.9, 'ao')
# sheild_material.add_material(natural_copper, 0.1, 'ao')



mats = openmc.Materials([natural_lead]) # hint, you will need to add all the materials used in the model to this list
mats.export_to_xml()



#example surfaces
surface_sph1 = openmc.Sphere(R=100) #hint, change the radius of this shpere to 500
surface_sph2 = openmc.Sphere(R=200) #hint, change the radius of this shpere to 500+100

volume_sph1 = +surface_sph1 & -surface_sph2 # above (+) surface_sph and below (-) surface_sph2

#add surfaces here using https://openmc.readthedocs.io/en/stable/usersguide/geometry.html#surfaces-and-regions

#example cell
cell_1 = openmc.Cell(region=volume_sph1)
cell_1.fill = natural_lead

#add another cell here

universe = openmc.Universe(cells=[cell_1]) #hint, this list will need to include the new cell

plt.show(universe.plot(width=(400,400),basis='xz',colors={cell_1: 'blue'})) #hint the width might need to be increased so you can see the new model
plt.show(universe.plot(width=(400,400),basis='xy',colors={cell_1: 'blue'}))
plt.show(universe.plot(width=(400,400),basis='yz',colors={cell_1: 'blue'}))

geom = openmc.Geometry(universe)





