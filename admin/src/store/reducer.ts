import { UserAction } from './action'

const defaultState = {
    id: 0,
    name: '',
    role: 2
}

const reducer = (state = defaultState, action: UserAction) => {
    switch (action.type) {
        case 'SET_USR_INFO':
            return action.value;
        case 'DEL_USER_INFO':
            return defaultState
        default:
            return state
    }
}
export default reducer