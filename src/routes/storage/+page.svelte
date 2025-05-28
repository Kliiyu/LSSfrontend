<script lang="ts">
    import { onMount } from 'svelte';

    interface InventoryItem {
        id: number;
        name: string;
        category: string;
        image: string;
        location: string;
        stock: number;
    }
    
    let inventoryItems: InventoryItem[] = [];
    let loading = true;
    let searchQuery = '';
    let sortBy = 'name';
    let ascending = true;

    const mockInventoryItems = [
        { id: 1, name: 'Laptop', category: 'Elektronikk', image: 'https://placehold.co/100x100?text=Laptop', location: 'Kontor A', stock: 5 },
        { id: 2, name: 'Smarttelefon', category: 'Elektronikk', image: 'https://placehold.co/100x100?text=Phone', location: 'Kontor B', stock: 8 },
        { id: 3, name: 'Kaffemaskin', category: 'Kjøkken', image: 'https://placehold.co/100x100?text=Coffee', location: 'Kjøkken', stock: 2 },
        { id: 4, name: 'Hodetelefoner', category: 'Elektronikk', image: 'https://placehold.co/100x100?text=Audio', location: 'Lagerrom', stock: 15 },
        { id: 5, name: 'Skrivebordslampe', category: 'Møbler', image: 'https://placehold.co/100x100?text=Lamp', location: 'Kontor C', stock: 7 },
        { id: 6, name: 'Blender', category: 'Kjøkken', image: 'https://placehold.co/100x100?text=Blender', location: 'Kjøkken', stock: 3 },
    ];

    onMount(() => {
        setTimeout(() => {
            inventoryItems = [...mockInventoryItems];
            loading = false;
        }, 800);
    });

    function handleSort(field: keyof InventoryItem) {
        if (sortBy === field) {
            ascending = !ascending;
        } else {
            sortBy = field;
            ascending = true;
        }
    }

    $: filteredItems = inventoryItems.filter(item => 
        item.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
        item.category.toLowerCase().includes(searchQuery.toLowerCase()) ||
        item.location.toLowerCase().includes(searchQuery.toLowerCase()) ||
        String(item.stock).includes(searchQuery)
    );

    $: sortedItems = [...filteredItems].sort((a, b) => {
        const valA = a[sortBy as keyof InventoryItem];
        const valB = b[sortBy as keyof InventoryItem];
        
        if (typeof valA === 'string') {
            return ascending 
                ? valA.localeCompare(valB as string) 
                : (valB as string).localeCompare(valA);
        } else {
            return ascending 
                ? (valA as number) - (valB as number) 
                : (valB as number) - (valA as number);
        }
    });
</script>

<div class="container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold mb-6">Lager Oversikt</h1>
    
    <div class="flex flex-col md:flex-row gap-4 mb-6 justify-between">
        <!-- Search -->
        <div class="form-control w-full md:w-64">
            <div class="input-group">
                <input 
                    type="text" 
                    bind:value={searchQuery} 
                    placeholder="Søk etter gjenstander..." 
                    class="input input-bordered w-full"
                />
            </div>
        </div>
        
        <button class="btn btn-primary">
            <i class="fas fa-plus mr-2"></i>
            Legg til nye varer
        </button>
    </div>

    {#if loading}
        <div class="flex justify-center my-12">
            <span class="loading loading-spinner loading-lg text-primary"></span>
        </div>
    {:else if sortedItems.length === 0}
        <div class="alert alert-info">
            <i class="fas fa-info-circle w-6 h-6"></i>
            <span>Ingen varer funnet. Prøv et annet søkeord eller legg til nye varer.</span>
        </div>
    {:else}
        <div class="overflow-x-auto rounded-lg shadow">
            <table class="table table-zebra w-full">
                <thead>
                    <tr>
                        <th>Bilde</th>
                        <th on:click={() => handleSort('name')} class="cursor-pointer">
                            Navn {sortBy === 'name' ? (ascending ? '↑' : '↓') : ''}
                        </th>
                        <th on:click={() => handleSort('category')} class="cursor-pointer">
                            Kategori {sortBy === 'category' ? (ascending ? '↑' : '↓') : ''}
                        </th>
                        <th on:click={() => handleSort('location')} class="cursor-pointer">
                            Plassering {sortBy === 'location' ? (ascending ? '↑' : '↓') : ''}
                        </th>
                        <th on:click={() => handleSort('stock')} class="cursor-pointer">
                            Beholdning {sortBy === 'stock' ? (ascending ? '↑' : '↓') : ''}
                        </th>
                        <th>Handlinger</th>
                    </tr>
                </thead>
                <tbody>
                    {#each sortedItems as item}
                        <tr>
                            <td>
                                <div class="avatar">
                                    <div class="mask mask-squircle w-12 h-12">
                                        <img src={item.image} alt={item.name} />
                                    </div>
                                </div>
                            </td>
                            <td>{item.name}</td>
                            <td>
                                <div class="badge badge-ghost">{item.category}</div>
                            </td>
                            <td>
                                <div class="badge badge-outline">{item.location}</div>
                            </td>
                            <td>
                                <div class={`badge ${item.stock > 0 ? 'badge-success' : 'badge-error'}`}>
                                    {item.stock}
                                </div>
                            </td>
                            <td>
                                <div class="flex gap-2">
                                    <button class="btn btn-sm btn-ghost btn-circle" aria-label="Se detaljer">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="btn btn-sm btn-ghost btn-circle" aria-label="Rediger">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-ghost btn-circle text-error" aria-label="Slett">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    {/each}
                </tbody>
            </table>
        </div>

        <div class="flex justify-between mt-6 items-center">
            <p class="text-sm text-gray-600">Viser {sortedItems.length} varer</p>
            <div class="join">
                <button class="join-item btn" aria-label="Første side"><i class="fas fa-angle-double-left"></i></button>
                <button class="join-item btn btn-active">1</button>
                <button class="join-item btn">2</button>
                <button class="join-item btn">3</button>
                <button class="join-item btn" aria-label="Siste side"><i class="fas fa-angle-double-right"></i></button>
            </div>
        </div>
    {/if}
</div>
