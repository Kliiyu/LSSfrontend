<script lang="ts">
	import '../app.css';
	import Navbar from '$lib/components/Navbar.svelte';
	import Sidebar from '$lib/components/Sidebar.svelte';
	import { page } from '$app/state';
	import { isAuthenticated, userId, username } from '$lib/stores';

	let { children, data } = $props();

	let isAuth = $derived(page.url.pathname.includes("auth"));
	let isErrorPage = $derived(page.status >= 400);

	$effect(() => {
		isAuthenticated.set(data.isAuthenticated);
		userId.set(data.userId);
		username.set(data.username);
	});
</script>

<div class="flex flex-col min-h-screen">
	{#if !isErrorPage}
		<Navbar />
		<div class="flex flex-1">
			{#if !isAuth}
				<Sidebar />
			{/if}
			<main class="flex-1 p-4">
				{@render children()}
			</main>
		</div>
	{:else}
		{@render children()}
	{/if}
</div>
