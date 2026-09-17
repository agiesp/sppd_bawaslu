import { router } from '@inertiajs/vue3'

export interface LoginPayload {
  email: string
  password: string
  remember?: boolean
}

export const useLogin = (payload: LoginPayload) => {
  return router.post('/login', {
    email: payload.email,
    password: payload.password,
    remember: payload.remember ?? false,
  })
}

export const useLogout = () => {
  return router.post('/logout')
}
