<script lang="ts">
    import { onMount } from 'svelte';

    interface Item {
        id: number;
        name: string;
        serialNumber: string;
        category: string;
        image: string;
        location: string;
        assignedUser: string;
    }
    
    let items: Item[] = [];
    let loading = true;
    let searchQuery = '';
    let sortBy = 'name';
    let ascending = true;

    const mockItems = [
        { id: 1, name: 'Laptop', serialNumber: 'SN-L1001', category: 'Elektronikk', image: 'https://placehold.co/100x100?text=Laptop', location: 'Kontor A', assignedUser: 'John Doe' },
        { id: 2, name: 'Smarttelefon', serialNumber: 'SN-S2002', category: 'Elektronikk', image: 'https://placehold.co/100x100?text=Phone', location: 'Kontor B', assignedUser: 'Jane Smith' },
        { id: 3, name: 'Kaffemaskin', serialNumber: 'SN-C3003', category: 'Kjøkken', image: 'https://placehold.co/100x100?text=Coffee', location: 'Kjøkken', assignedUser: 'Kjøkkenpersonale' },
        { id: 4, name: 'Hodetelefoner', serialNumber: 'SN-H4004', category: 'Elektronikk', image: 'https://placehold.co/100x100?text=Audio', location: 'Lagerrom', assignedUser: 'Alex Johnson' },
        { id: 5, name: 'Skrivebordslampe', serialNumber: 'SN-D5005', category: 'Møbler', image: 'https://placehold.co/100x100?text=Lamp', location: 'Kontor C', assignedUser: 'Michael Brown' },
        { id: 6, name: 'Blender', serialNumber: 'SN-B6006', category: 'Kjøkken', image: 'https://placehold.co/100x100?text=Blender', location: 'Kjøkken', assignedUser: 'Sarah Wilson' },
    ];

    onMount(() => {
        setTimeout(() => {
            items = [...mockItems];
            loading = false;
        }, 800);
    });

    function handleSort(field: keyof Item) {
        if (sortBy === field) {
            ascending = !ascending;
        } else {
            sortBy = field;
            ascending = true;
        }
    }

    $: filteredItems = items.filter(item => 
        item.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
        item.category.toLowerCase().includes(searchQuery.toLowerCase()) ||
        item.serialNumber.toLowerCase().includes(searchQuery.toLowerCase()) ||
        item.location.toLowerCase().includes(searchQuery.toLowerCase()) ||
        item.assignedUser.toLowerCase().includes(searchQuery.toLowerCase())
    );

    $: sortedItems = [...filteredItems].sort((a, b) => {
        const valA = a[sortBy as keyof Item];
        const valB = b[sortBy as keyof Item];
        
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
    <h1 class="text-3xl font-bold mb-6">Utlånt Utstyr</h1>
    
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
            Lån ut nytt utstyr
        </button>
    </div>

    {#if loading}
        <div class="flex justify-center my-12">
            <span class="loading loading-spinner loading-lg text-primary"></span>
        </div>
    {:else if sortedItems.length === 0}
        <div class="alert alert-info">
            <i class="fas fa-info-circle w-6 h-6"></i>
            <span>Ingen utstyr funnet. Prøv et annet søkeord eller legg lån ut utstyr.</span>
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
                        <th on:click={() => handleSort('serialNumber')} class="cursor-pointer">
                            Serienummer {sortBy === 'serialNumber' ? (ascending ? '↑' : '↓') : ''}
                        </th>
                        <th on:click={() => handleSort('location')} class="cursor-pointer">
                            Plassering {sortBy === 'location' ? (ascending ? '↑' : '↓') : ''}
                        </th>
                        <th on:click={() => handleSort('assignedUser')} class="cursor-pointer">
                            Tildelt bruker {sortBy === 'assignedUser' ? (ascending ? '↑' : '↓') : ''}
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
                            <td>{item.serialNumber}</td>
                            <td>
                                <div class="badge badge-outline">{item.location}</div>
                            </td>
                            <td>
                                <div class="badge badge-primary">{item.assignedUser}</div>
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
            <p class="text-sm text-gray-600">Viser {sortedItems.length} utstyr</p>
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
