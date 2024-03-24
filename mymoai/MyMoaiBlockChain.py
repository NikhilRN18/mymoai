import networkx as nx
import matplotlib.pyplot as plt

class Block:
    def __init__(self, index, previous_hash, data):
        self.index = index
        self.previous_hash = previous_hash
        self.data = data

def create_genesis_block():
    return Block(0, "0", "Genesis Block")

def create_new_block(previous_block, data):
    index = previous_block.index + 1
    return Block(index, previous_block.index, data)

# Create blockchain and add genesis block
blockchain = [create_genesis_block()]
previous_block = blockchain[0]

# Add blocks to the blockchain
num_blocks_to_add = 10
for i in range(0, num_blocks_to_add):
    block_to_add = create_new_block(previous_block, f"Block #{i} has been added to the blockchain!")
    blockchain.append(block_to_add)
    previous_block = block_to_add

# Create a directed graph
G = nx.DiGraph()

# Add nodes and edges to the graph
for block in blockchain:
    G.add_node(block.index, label=block.data)
    if block.index > 0:
        G.add_edge(block.index, block.previous_hash)

# Draw the graph
pos = nx.spring_layout(G)
labels = nx.get_node_attributes(G, 'label')
nx.draw(G, pos, with_labels=True, font_weight='bold')
nx.draw_networkx_labels(G, pos, labels)
plt.show()
