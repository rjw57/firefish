"""
Test loading geometry

"""
import os

import pytest
import stl.mesh

def _geom_dir():
    """Return the path to the test geometry directory."""
    geom_dir = os.path.join(os.path.dirname(__file__), 'geometry')
    assert os.path.isdir(geom_dir)
    return geom_dir

@pytest.fixture
def unit_sphere_stl():
    """Path to a simple STL file containing a unit sphere."""
    stl_path = os.path.join(_geom_dir(), 'unit_sphere.stl')
    assert os.path.isfile(stl_path)
    return stl_path

def test_load_unit_sphere(unit_sphere_stl):
    """Loading a simple STL file succeeds."""
    print('Loading STL at: {}'.format(unit_sphere_stl))
    stl.mesh.Mesh.from_file(unit_sphere_stl)

def test_save_unit_sphere(unit_sphere_stl, tmpdir):
    """Saving a copy of a simple STL file succeeds."""
    print('Loading STL at: {}'.format(unit_sphere_stl))
    m = stl.mesh.Mesh.from_file(unit_sphere_stl)

    out_path = tmpdir.join('out.stl')
    print('Saving to: {}'.format(out_path.strpath))
    m.save(out_path.strpath)

    assert out_path.check()
    assert out_path.size() > 0
