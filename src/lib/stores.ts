import { writable } from 'svelte/store';

export const isAuthenticated = writable(false);
export const userId = writable('');
export const username = writable('');
