<script lang="ts">
    import { onMount } from 'svelte';
    import { PieChart } from "@carbon/charts-svelte";
    
    interface PieDataItem {
        group: string;
        value: number;
    }
    
    let pieData: PieDataItem[] = [];
    
    let pieOptions = {
        title: "Utstyr Fordeling",
        resizable: true,
        height: "300px"
    };
    
    let stats = [
        { title: "Utstyr på Lager", value: "1,000", change: "+5.1%", icon: "📦", pos: false },
        { title: "Utstyr utdelt", value: "315", change: "+3.3%", icon: "💻", pos: true },
        { title: "Ventende Bestillinger", value: "42", change: "-2.5%", icon: "🚚", pos: false },
        { title: "Produkter med utgått innleveringsfrist", value: "18", change: "-12.8%", icon: "⚠️", pos: false }
    ];
    
    onMount(() => {
        pieData = [
            { group: "Utdelt", value: 65 },
            { group: "På Lager", value: 15 },
            { group: "Under Bestilling", value: 12 },
            { group: "Må leveres", value: 8 }
        ];
    });
</script>

<div class="p-6 bg-base-100 min-h-screen">
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
        {#each stats as stat}
            <div class="bg-base-200 rounded-lg shadow p-4">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-content">{stat.title}</p>
                        <p class="text-2xl font-bold">{stat.value}</p>
                    </div>
                    <div class="text-3xl">{stat.icon}</div>
                </div>
                <div class={`text-sm ${(stat.pos && stat.change.includes('+')) || (!stat.pos && stat.change.includes('-')) ? 'text-green-600' : 'text-red-600'}`}>
                    {stat.change} fra forrige måned
                </div>
            </div>
        {/each}
    </div>
    
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
        <div class="bg-white rounded-lg shadow p-4">
            <PieChart data={pieData} options={pieOptions} />
            <p class="mt-2 text-sm text-black text-center">Fordeling av lagerstatusen for alt utstyr.</p>
        </div>
    </div>
</div>