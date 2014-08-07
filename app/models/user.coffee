`import BaseModel from './base'`

User = BaseModel.extend
    relations: ['organization']

    username: null
    email: null

    isOwner: null

    organization: null

`export default User`
