<script lang="ts">
    import { isAuthenticated, userId, username } from '$lib/stores';
    let profileModalOpen = false;

    function toggleProfileModal() {
        profileModalOpen = !profileModalOpen;
    }
</script>

<div class="navbar bg-base-300 shadow-md px-4 py-3">
    <div class="flex-1">
        <a href="/" class="btn btn-ghost text-xl">
            LSS
        </a>
    </div>
    <div class="flex-none gap-2">
        {#if $isAuthenticated}
            <div class="dropdown dropdown-end">
                <div tabindex="0" role="button" class="btn btn-ghost btn-circle avatar">
                    <div class="w-10 rounded-full">
                        <img
                            alt="Avatar"
                            src="https://avatar.iran.liara.run/username?username={$username.slice(0, Math.ceil($username.length / 2)) + '+' + $username.slice(Math.ceil($username.length / 2))}" />
                    </div>
                </div>
                <ul
                    class="menu menu-sm dropdown-content bg-base-100 rounded-box z-[1] mt-3 w-52 p-2 shadow">
                    <li>
                        <button on:click={toggleProfileModal} class="justify-between">
                            Profil
                        </button>
                    </li>
                    <li><a href="/settings">Innstillinger</a></li>
                    <li><a href="/auth/logout">Logg ut</a></li>
                </ul>
            </div>
        {:else}
            <div class="flex gap-3">
                <a href="/auth/login" class="btn btn-sm btn-primary">Logg inn</a>
                <a href="/auth/signup" class="btn btn-sm btn-outline btn-secondary">Lag Bruker</a>
            </div>
        {/if}
    </div>
</div>

{#if profileModalOpen}
    <div class="modal modal-open">
        <div class="modal-box">
            <div class="py-4">
                <div class="flex flex-col items-center gap-4">
                    <div class="avatar">
                        <div class="w-24 rounded-full">
                            <img 
                                alt="Avatar" 
                                src="https://avatar.iran.liara.run/username?username={$username.slice(0, Math.ceil($username.length / 2)) + '+' + $username.slice(Math.ceil($username.length / 2))}" />
                        </div>
                    </div>
                    <div class="text-center">
                        <h2 class="text-xl font-semibold">{$username}</h2>
                        <p class="text-sm opacity-70">Bruker ID: {$userId}</p>
                    </div>
                </div>
            </div>
            <div class="modal-action">
                <button class="btn" on:click={toggleProfileModal}>Lukk</button>
            </div>
        </div>
    </div>
{/if}
