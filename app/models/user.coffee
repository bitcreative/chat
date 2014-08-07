`import BaseModel from './base'`

User = BaseModel.extend
    username: null
    email: null

    isOwner: null

    organization: null

`export default User`
