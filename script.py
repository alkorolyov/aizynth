import sqlite3
from IPython.display import display
from aizynthfinder.reactiontree import ReactionTreeFromDict


def draw_tree_by_id(i: int):
    with sqlite3.connect('results.db') as conn:
        res = conn.execute(f'''
        SELECT tree_dict FROM synthetic_routes
        WHERE id = {i}
        ''').fetchall()[0][0]

    if res:
        tree_dict = eval(res)
        tree = ReactionTreeFromDict(tree_dict).tree
        display(tree.to_image())

if __name__ == '__main__':
    draw_tree_by_id(9)